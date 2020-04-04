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

    var viewModel = RefillsViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        setupCollectionView()
    }

    func setupCollectionView() {
       let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 200, right: 0)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = viewModel.dataSource
        collectionView.delegate = self
        collectionView.register(RefillCell.nib, forCellWithReuseIdentifier: RefillCell.reuseID)
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .systemBackground
        
        
        self.viewModel.dataSource.addAndNotify(observer: self) { state in
            switch state.stateChange {
            case .reload(_):
                collectionView.reloadData()
            case let .insert(_, indexPath):
                collectionView.insertItems(at: [indexPath])
            case let .delete(indexPath):
                collectionView.deleteItems(at: [indexPath])
            default:
                break
            }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let editRefillController = RefillEditController(nibName: "RefillEditController", bundle: nil)
        editRefillController.refill = viewModel.dataSource.value.data[indexPath.row]
        editRefillController.editingMode = true
        self.present(editRefillController, animated: true, completion: nil)
    }
}

extension RefillsController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(named: "report_card"))
    }
}
