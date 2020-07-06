//
//  DeleteClass.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 01.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

protocol ObjectForDeleteProtocol: class {
    func deleteObject(_ object: Any, complition: @escaping(_ done: Bool) -> Void)
}

class DeleteClass: NetworkSupportProtocol {
    var objectForDelete: Any?
    init(objectForDelete: Any) {
        self.objectForDelete = objectForDelete
    }
    func chooseRequest(with request: Request, compliton: @escaping (Any?) -> Void) {
        switch request {
// MARK: - Delete Billings
        case .deleteBilling:
            if objectForDelete is BillingModel {
                guard let billing = objectForDelete as? BillingModel else {return}
                let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
                let params = ["id": billing.id]
                AF.request(request.rawValue, method: .delete,
                                             parameters: params,
                                             headers: headers)
                                                    .response { (response) in
                    if response.error != nil {
                        compliton(nil)
                    }
                    print("ObjectDeleted")
                    compliton(true)
                    compliton(response)
                }
            } else {
                compliton(false)
            }
// MARK: - Delete Transactions
        case .deleteTransaction:
            if objectForDelete is TransactionModel {
                guard let transaction = objectForDelete as? TransactionModel else {return}
                let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
                let params = ["id": transaction.id]
                AF.request(request.rawValue, method: .delete,
                                             parameters: params,
                                             headers: headers)
                                                    .response { (response) in
                    if response.error != nil {
                        compliton(nil)
                    }
                    compliton(true)
                    compliton(response)
                }
            } else {
                compliton(false)
            }
        default:
            return
        }
    }
}
