//
//  ExtNewBillingViewCloseProtocol.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension BillingViewController: NewBillingViewCloseProtocol {
    func close() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.newBillingView.view.alpha = 0
        })
        { [weak self] (done) in
            if done {
                self?.visualEffectView.removeFromSuperview()
                self?.newBillingView.view.removeFromSuperview()
            }
        }
    }
}
