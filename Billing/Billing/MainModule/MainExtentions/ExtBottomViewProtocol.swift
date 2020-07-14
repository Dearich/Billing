//
//  ExtBottomViewProtocol.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension BillingViewController: BottomViewProtocol {
    func showNewTransactionView() {
        addBlurEffect()
        self.addChild(newTransactionView)
        newTransactionView.view.frame = self.view.frame
        self.view.addSubview(newTransactionView.view)
        newTransactionView.didMove(toParent: self)
        newTransactionView.becomeFirstResponder()
        newTransactionView.view.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            self.newTransactionView.view.alpha = 1.0
        }
    }
    
}
