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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 200, right: 0)
        
        let myCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(RefillCell.self, forCellWithReuseIdentifier: RefillCell.reuseID)
        
        myCollectionView.register(RefillCell.nib, forCellWithReuseIdentifier: RefillCell.reuseID)
        myCollectionView.contentInset = .zero
        
        self.view.addSubview(myCollectionView)
    }

    
}

extension RefillsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefillCell.reuseID, for: indexPath) as? RefillCell else {
            fatalError("Wrong cell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 150)
    }
    
    
}



extension RefillsController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(named: "report_card"))
    }
    
    
}
