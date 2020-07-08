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

protocol HeaderDataSourceProtocol: class {
    func shouldStartAnimation()
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout { get }
    var control: UIPageControl { get }
    var collectionView: UICollectionView { get }
}
protocol BillingPopUpProtocol: class {
    func showPopUp(_ billing: BillingModel)
}
class HeaderDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var billingArray: [Any] = []
    weak var billingPopUpProtocol: BillingPopUpProtocol?
    weak var headerDataSourceDelegate: HeaderDataSourceProtocol?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return billingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HeaderCollectionViewCell
            else { return UICollectionViewCell() }
        cell.billing = billingArray[indexPath.row]
        cell.fromCelltoHeaderVew = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //проверка если центральная ячейка не выбрана, то осуществить переход на нее
        let currentCenteredPage = headerDataSourceDelegate?.centeredCollectionViewFlowLayout.currentCenteredPage
        if currentCenteredPage != indexPath.row {
            headerDataSourceDelegate?.centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
            headerDataSourceDelegate?.control.currentPage = indexPath.row
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let cells = headerDataSourceDelegate?.collectionView.visibleCells else { return }
        for cell in cells {
            guard let indexPath = headerDataSourceDelegate?.collectionView.indexPath(for: cell) else { return }
            let currentCenteredPage = headerDataSourceDelegate?.centeredCollectionViewFlowLayout.currentCenteredPage
            if currentCenteredPage == indexPath.row {
                headerDataSourceDelegate?.control.currentPage = indexPath.row
            }
        }
    }
}

// MARK: - Size for Cells

extension HeaderDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190.0, height: collectionView.frame.height * 0.75)
    }
}
extension HeaderDataSource: FromCelltoHeaderView {
    func fromCelltoHeader(_ billing: BillingModel) {
        billingPopUpProtocol?.showPopUp(billing)
        
    }
}
