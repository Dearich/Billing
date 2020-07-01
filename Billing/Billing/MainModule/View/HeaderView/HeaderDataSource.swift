//
//  HeaderDataSource.swift
//  Billing
//
//  Created by Азизбек on 01.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderDataSourceProtocol:class {
    func shouldStartAnimation()
}

class HeaderDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var billingArray: [Any] = []
    weak var headerDataSourceDelegate: HeaderDataSourceProtocol?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("HeaderDataSource")
        return billingArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HeaderCollectionViewCell
            else { return UICollectionViewCell() }
        cell.billing = billingArray[indexPath.row]
        cell.showPopUpViewDelegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - Size for Cells

extension HeaderDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: collectionView.frame.height * 0.7)
    }
}

extension HeaderDataSource: ShowPopUpViewProtocol {
    func animationAddView() {
        headerDataSourceDelegate?.shouldStartAnimation()
    }

}
