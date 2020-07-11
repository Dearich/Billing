//
//  HeaderDataSource.swift
//  Billing
//
//  Created by Азизбек on 01.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit
import CenteredCollectionView

protocol HeaderDataSourceProtocol:class {
    func shouldStartAnimationAddView()
    func shouldStartAnimationDeleteView(billing: BillingModel?)
    var control: UIPageControl { get }
    var collectionView: UICollectionView { get }
    var deleteView: DeleteViewController? { get }
}

class HeaderDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var billingArray: [Any] = []
    weak var headerDataSourceDelegate: HeaderDataSourceProtocol?
    var deleteView: DeleteViewController?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return billingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                            for: indexPath) as? HeaderCollectionViewCell
            else { return UICollectionViewCell() }
        cell.billing = billingArray[indexPath.row]
        cell.showPopUpViewDelegate = self
        deleteView = headerDataSourceDelegate?.deleteView
        
        return cell
    }
}

// MARK: - Size for Cells

extension HeaderDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190.0, height: collectionView.frame.height * 0.75)
    }
}

extension HeaderDataSource: ShowPopUpViewProtocol {

    func animationDeleteView(billing: BillingModel?) {
        headerDataSourceDelegate?.shouldStartAnimationDeleteView(billing: billing)
    }

    func animationAddView() {
        headerDataSourceDelegate?.shouldStartAnimationAddView()
    }
    
}
