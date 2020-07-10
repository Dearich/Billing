//
//  GetClass.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

class GetClass {

    private let backgroundQueue = DispatchQueue(label: "azizbek.ru/backgroundTask",
                                                qos: .background, attributes: .concurrent)
    func getBillings(with request: Request, compliton: @escaping ([Any]?, Error?) -> Void) {
        
        AF.request(request.rawValue).responseJSON(queue: backgroundQueue) { (response) in
            JsonHelper.shared.parseBilling(with: response) { (billings, error) in
                if let error = error {
                    compliton( nil, error )
                }
                if let billings = billings {
                    compliton( billings,nil )
                }
            }
        }
    }

    func getTransaction(with request: Request, compliton: @escaping ([TransactionModel]?, Error?) -> Void) {
        AF.request(request.rawValue).responseJSON { (response) in
            JsonHelper.shared.parseTransaction(data: response) { (transaction, error) in
                if let error = error {
                    compliton( nil, error )
                }
                if let transaction = transaction {
                    compliton( transaction,nil )
                }
            }
        }
    }
}
