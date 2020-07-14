//
//  MainPresenter.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class MainPresenter {
    
    let view: BillingViewController
    lazy var getClass = GetClass()
    let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    required init(view: BillingViewController) {
        self.view = view
    }
    
    func getBillings() {
        self.view.activityIndicator.startAnimating()
        if CheckInternetConnection.Connection() {
            view.newBillingView.addNewBillingDelegate = self
            getClass.getBillings(with: .getBilling) { [weak self] (billings, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self?.view.activityIndicator.stopAnimating()
                    self?.view.activityIndicator.isHidden = true
                    self?.view.setUpHeaderView(billingArray: billings)
                }
            }
        } else {
            UIAlertController(alertType: .lostInternet, presenter: self)
        }
    }
    
    func getTransaction() {
        if CheckInternetConnection.Connection() {
            getClass.getTransaction(with: .getTransaction) { [weak self] (transactions, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self?.view.setUpBottomView(transactionArray: transactions)
                }
            }
        } else {
            UIAlertController(alertType: .lostInternet, presenter: self)
        }
    }
}
