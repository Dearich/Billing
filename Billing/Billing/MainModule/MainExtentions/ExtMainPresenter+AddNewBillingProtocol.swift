//
//  ExtMainPresenter+AddNewBillingProtocol.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 14.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension MainPresenter: AddNewBillingProtocol {
    func addNewBillingAndUpdate(balance: String, complition: @escaping ((Bool) -> Void)) {
        let timestamp = Date().timeIntervalSince1970
        let ownerID = 1
        let savingObj = NewBilling(balance: balance, date: Int(timestamp), ownerID: ownerID)
        let post = PostClass(savingObject: savingObj)
        post.saveBilling(with: .postBilling) {[weak self] (response, error) in
            if error != nil {
                complition( false )
            }
            if response != nil {
                complition( true )
                self?.getBillings()
            }
        }
    }
}
