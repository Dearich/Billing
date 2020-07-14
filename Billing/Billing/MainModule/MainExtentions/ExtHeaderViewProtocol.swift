//
//  ExtHeaderViewProtocol.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension BillingViewController: HeaderViewProtocol {
    
    fileprivate func haptikEngine(_ generator: UINotificationFeedbackGenerator) {
        generator.notificationOccurred(.success)
        addBlurEffect()
    }
    
    func showPopUpDeleteView(billing: BillingModel?) {
        let generator = UINotificationFeedbackGenerator()
        haptikEngine(generator)
        deleteView = ModuleBuilder.createDelete()
        guard let deleteView = deleteView else { return }
        deleteView.billingViewController = self
        deleteView.presenter.cellBilling = billing
        self.addChild(deleteView)
        deleteView.view.frame = self.view.frame
        self.view.addSubview(deleteView.view)
        deleteView.didMove(toParent: self)
        deleteView.becomeFirstResponder()
        deleteView.view.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            deleteView.view.alpha = 1.0
        }
    }
    
    func showPopUpAddView() {
        animationAddView()
    }
}
