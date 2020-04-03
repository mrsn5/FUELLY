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

    var viewModel = StationsViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        setupCollectionView()
    }
    
    func setupCollectionView() {
       let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 200, right: 0)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = viewModel.dataSource
        collectionView.delegate = self
        collectionView.register(StationCell.nib, forCellWithReuseIdentifier: StationCell.reuseID)
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .systemBackground
        
        self.viewModel.dataSource.addAndNotify(observer: self) { state in
            switch state.stateChange {
                case let .reload(ref):
                    print("reload \(ref.count)")
                case let .insert(r, indexPath):
                    print("insert \(r)")
                case let .delete(indexPath):
                    print("delete")
            }
            
            collectionView.reloadData()
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension StationsController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(image: UIImage(named: "combo_chart"))
    }
}
