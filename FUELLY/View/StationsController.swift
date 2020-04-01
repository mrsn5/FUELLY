//
//  StationsController.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//


import UIKit
import XLPagerTabStrip

class StationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
       let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 200, right: 0)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StationCell.nib, forCellWithReuseIdentifier: StationCell.reuseID)
        collectionView.contentInset = .zero
        
        self.view.addSubview(collectionView)
    }
}

extension StationsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationCell.reuseID, for: indexPath) as? StationCell else {
            fatalError("Wrong cell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 230)
    }
    
    
}

extension StationsController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(image: UIImage(named: "combo_chart"))
    }
}
