//
//  NewTransactionPresenter.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class NewTransactionPresenter {

    let view: NewTransactionViewController

    required init(view: NewTransactionViewController) {
        self.view = view
    }
    func saveTransaction() {
        let timestamp = Date().timeIntervalSince1970
        let ownerID = 1
        let selectedSegment = view.segmentedControl.selectedSegmentIndex
        guard let selectedImageName = view.segmentedControl.titleForSegment(at: selectedSegment) else { return }
        guard let sumText = view.sumTextField.text else { return }
        guard let titleText = view.titleTextField.text else { return }
        let newTransaction = NewTransactionModel(date: Int(timestamp),
                                            icon: "\(selectedImageName)",
                                            ownerID: ownerID,
                                            sum: Int(sumText) ?? 0,
                                            title: titleText)
        let postTransaction = PostClass(savingObject: newTransaction)
        postTransaction.saveTransaction(with: .postTransaction) { [weak self] (response, error) in
            if error != nil {
                _ = UIAlertController(alertType: .gotError, or: self?.view)
            }
            if response != nil {
                self?.view.billingViewController?.presenter.getTransaction()
            }
        }
    }
}
