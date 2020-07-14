//
//  ExtHeaderCollectionView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 14.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension HeaderCollectionView {
    func addConstraints(_ constant: CGFloat, _ subView: UIView) {
        if subView == collectionView {
            subView.addConstraintsWithFormat(format: "V:|-[v0]-\(constant)-|", views: collectionView)
            subView.addConstraintsWithFormat(format: "H:|-[v0]-|", views: collectionView)
        } else if subView == control {
            subView.addConstraintsWithFormat(format: "V:[v0(\(constant))]-|", views: control)
            subView.addConstraintsWithFormat(format: "H:|-[v0]-|", views: control)
        }
    }
}
