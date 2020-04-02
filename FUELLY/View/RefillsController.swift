//
//  RefillsController.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RefillsController: UIViewController {

    let dataSource = RefillsDataSource()
    
    lazy var viewModel : RefillsViewModel = {
        return RefillsViewModel(dataSource: dataSource)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
        setupCollectionView()
    }

    func setupCollectionView() {
       let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 200, right: 0)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(RefillCell.nib, forCellWithReuseIdentifier: RefillCell.reuseID)
        collectionView.contentInset = .zero
//        collectionView.backgroundColor = .white
        
        self.dataSource.addAndNotify(observer: self) { state in
            switch state.editingStyle {
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

extension RefillsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension RefillsController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(named: "report_card"))
    }
}
