//
//  PickStationView.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 02.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import MapKit

class MapStationView: UIViewController {

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var searchBarView: UIView!
    @IBOutlet weak var confirmButton: DefaultButton!
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    
    var selectedPin: DynamicValue<MKPlacemark?> = DynamicValue(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMapView()
        setupSearch()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
        selectedPin.addAndNotify(observer: self) { (newPlacemark) in
            self.confirmButton.isHidden = newPlacemark == nil
        }
    }
    
    func setUpMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.showsScale = false
        currentLocation()
    }
    
    func currentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()
    }
    
    func searchStations() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "gas station"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            self.mapView.removeAnnotations(self.mapView.annotations)
            self.selectedPin.value = nil
            for item in response.mapItems {
                let pin = PlacemarkAnnotation(placemark: item.placemark)
                self.mapView.addAnnotation(pin)
            }
        }
    }
    
    
    @IBAction func searchThisAreaTapped(_ sender: Any) {
        searchStations()
    }
    
    @IBAction func confirmed(_ sender: Any) {
        guard let placemark = selectedPin.value else { return }
        let stationCreationView = StationCreationView(nibName: "StationCreationView", bundle: nil)
        stationCreationView.station = Station(placemark: placemark)
        stationCreationView.dismissCallback = {
            self.dismiss(animated: true, completion: nil)
        }
        
        
        self.present(stationCreationView, animated: true, completion: nil)
    }
    
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {

        let viewCoord = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert (viewCoord, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation( location, completionHandler: { (placemarks, error) in
            guard let clplacemark = placemarks?[0] else {return}
            let placemark = MKPlacemark(placemark: clplacemark)
            
            let annotation = PlacemarkAnnotation(placemark: placemark)
            annotation.coordinate = coordinate
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
            self.selectedPin.value = placemark
        })
    }
}
extension MapStationView {
    
    func setupSearch() {
        let locationSearchTable = LocationSearchTable(nibName: "LocationSearchTable", bundle: nil)
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.obscuresBackgroundDuringPresentation = false
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for stations"
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.layer.cornerRadius = 10.0
            textfield.layer.borderWidth = 1.0
            textfield.layer.borderColor = UIColor.clear.cgColor
            textfield.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            textfield.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            textfield.layer.shadowOpacity = 0.33
            textfield.layer.shadowRadius = 2
            
            textfield.textColor = .black
        }
        navigationItem.searchController = resultSearchController
        
        searchBarView.addSubview(searchBar)
        
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
}

extension MapStationView: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark) {

        selectedPin.value = placemark
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = PlacemarkAnnotation(placemark: placemark)
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
    
    }
}


extension MapStationView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error.localizedDescription)
    }
}

extension MapStationView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let placemarkAnnotation = view.annotation as? PlacemarkAnnotation else {
            self.selectedPin.value = nil
            return
        }
        self.selectedPin.value = placemarkAnnotation.placemark
    }
}
