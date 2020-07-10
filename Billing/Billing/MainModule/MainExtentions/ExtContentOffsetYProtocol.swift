//
//  File.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension BillingViewController: ContentOffsetYProtocol {

    func headerAnimation(contentOffsetY: CGFloat, complition: @escaping ((CGFloat) -> Void)) {
        let minHight = presenter.statusBarHeight + 30
        let newHight = (self.heightConstraint.constant) - contentOffsetY
        let headerViewMaxHeight = self.view.frame.height / 4
        self.heightConstraint.isActive = false

        if newHight > headerViewMaxHeight {

            self.heightConstraint.constant = headerViewMaxHeight
            NSLayoutConstraint.activate([self.heightConstraint])
            print("newHight > presenter.headerViewMaxHeight: \(self.heightConstraint.constant)")

        } else if newHight < minHight {

            self.heightConstraint.constant = minHight
            NSLayoutConstraint.activate([self.heightConstraint])
            print("newHight < minHight: \(self.heightConstraint.constant)")
        } else {
            self.heightConstraint.constant = newHight
            NSLayoutConstraint.activate([self.heightConstraint])
            print("newHight: \(self.heightConstraint.constant)")
            complition(0)
        }
        let dinamicAlpha = ((self.heightConstraint.constant - headerViewMaxHeight) / minHight) + 1

        UIView.animate(withDuration: 0.25) {
            self.headerView.collectionView.alpha = dinamicAlpha
        }
    }
}
