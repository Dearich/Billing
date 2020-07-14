//
//  ExtUIViewController.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 14.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func close(billingViewController: BillingViewController?, view: UIView) {
        guard let billingViewController = billingViewController else { return }

        UIView.animate(withDuration: 0.3, animations: {
            billingViewController.visualEffectView.alpha = 0
            view.alpha = 0
        }) { (bool) in
            if bool == true {
                billingViewController.visualEffectView.removeFromSuperview()
                self.view.removeFromSuperview()
            }
           
        }
    }
}
