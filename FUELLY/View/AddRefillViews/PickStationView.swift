//
//  PickStationView.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 02.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import MapKit

class PickStationView: UIViewController {

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var searchBarView: UIView!
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMapView()
        setupSearch()
    }
    
    func setUpMapView() {
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.showsScale = false
        currentLocation()
    }
    
    func currentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *) {
            locationManager.showsBackgroundLocationIndicator = true
        } else {
            // Fallback on earlier versions
        }
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
            for item in response.mapItems {
                let coords = item.placemark.coordinate
                let pin = StationAnnotation(
                    title: item.name,
                    locationName: item.name,
                    coordinate: coords)
                self.mapView.addAnnotation(pin)
            }
        }
    }
    
    
    @IBAction func searchThisAreaTapped(_ sender: Any) {
        searchStations()
        
    }
}


extension PickStationView {
    
    func setupSearch() {
        let locationSearchTable = LocationSearchTable(nibName: "LocationSearchTable", bundle: nil)
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.obscuresBackgroundDuringPresentation = false
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for stations"
       
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
//            textfield.backgroundColor = .white
            
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
//        searchBar.center = CGPoint(x: searchBar.center.x,
//        y: searchBarView.frame.size.height / 2 + 10)
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
//        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
}

extension PickStationView: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark) {
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
    
    }
}


extension PickStationView: CLLocationManagerDelegate {
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
