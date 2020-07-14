//
//  DeletePresenter.swift
//  Billing
//
//  Created by Азизбек on 10.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class DeletePresenter {
 
    let view: DeleteViewController
    var collectionView: UICollectionView?
    var cellBilling: BillingModel?

    required init(view: DeleteViewController) {
        self.view = view
    }

    func setUpDeleteView() {

        guard let cellBilling = cellBilling else { return }
        view.balance.text = cellBilling.balance
        view.date.text = stringDate(cellBilling.date)
        view.owner.text = cellBilling.owner

    }

    func deleteBilling() {
        DeleteClass.shared.deleteBilling(with: .deleteBilling,
                                         objectForDelete: cellBilling) {[weak self] (response, error) in
            if error != nil {
             UIAlertController(alertType: .gotError, or: self?.view)
            }
            if response == response {
                self?.view.billingViewController?.presenter.getBillings()
            }
        }
    }
}
