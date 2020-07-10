//
//  PostClass.swift
//  Billing
//
//  Created by Азизбек on 02.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

class PostClass {

    let savingObject: Any

    init(savingObject: Any) {
        self.savingObject = savingObject
    }
    
    func saveBilling(with request: Request, compliton: @escaping (Any?, Error?) -> Void) {
        if savingObject is NewBilling {
            guard let billing = savingObject as? NewBilling else { return }
            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

            let parameters = [
                "balance": "\(billing.balance)",
                "date": "\(billing.date)",
                "ownerID": "\(billing.ownerID)"
            ]
            
            AF.request(request.rawValue,method: .post,
                       parameters: parameters,
                       headers:headers).response { (response) in
                        if let error = response.error {
                            compliton(nil, error )
                        }
                        compliton(response, nil)
            }
        }
    }

    func saveTransaction(with request: Request, compliton: @escaping (Any?, Error?) -> Void) {
        if savingObject is TransactionModel {
            guard let transaction = savingObject as? TransactionModel else { return }

            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

            let parameters = [
                "date": "\(transaction.date)",
                "icon": "\(transaction.icon)",
                "ownerID": "\(transaction.ownerID)",
                "sum": "\(transaction.sum)",
                "title": "\(transaction.title)"
            ]
            AF.request(request.rawValue,method: .post,
                       parameters: parameters,
                       headers:headers).response { (response) in
                        if let error = response.error {
                            compliton(nil, error )
                        }
                        compliton(response, nil)
            }
        }
    }
}
