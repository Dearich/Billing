//
//  Presenter.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter {

    let view: BillingViewController
   lazy var getClass = GetClass()
    let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    required init(view: BillingViewController) {
        self.view = view
    }

    func getBillings() {
        print("getData()")
        DispatchQueue.main.async {
            self.view.activityIndicator.startAnimating()
        }
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
            _ = UIAlertController(alertType: .lostInternet, presenter: self)
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
            _ = UIAlertController(alertType: .lostInternet, presenter: self)
        }
    }
}

extension MainPresenter:AddNewBillingProtocol {
    func addNewBillingAndUpdate(balance: String, complition: @escaping ((Bool) -> Void)) {
        let timestamp = Date().timeIntervalSince1970
        let ownerID = 1
        let savingObj = NewBilling(balance: balance, date: Int(timestamp), ownerID: ownerID)
        let post = PostClass(savingObject: savingObj)
        post.saveBilling(with: .postBilling) { (response, error) in
            if error != nil {
                complition( false )
            }
            if response != nil {
                complition( true )
            }
        }
    }
}
