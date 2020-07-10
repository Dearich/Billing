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
    func deleteObject(_ object: Any)
}

class DeleteClass {
    var objectForDelete: Any?
    init(objectForDelete: Any) {
        self.objectForDelete = objectForDelete
    }
    // MARK: - Delete Billings
    func deleteBilling(with request: Request, complition: @escaping(_ done: Any?) -> Void) {
        guard let billing = objectForDelete as? BillingModel else {return}
        let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        let params = ["id": billing.id]
        AF.request(request.rawValue, method: .delete,
                                            parameters: params,
                                            headers: headers)
                                            .response { (response) in
                if response.error != nil {
                    complition(nil)
                } else {
                    print("ObjectDeleted")
                    complition(response)
                }
        }
    }
    func deleteTransaction(with request: Request, complition: @escaping(_ done: Any?) -> Void) {
        if objectForDelete is TransactionModel {
            guard let transaction = objectForDelete as? TransactionModel else {return}
            let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
            let params = ["id": transaction.id]
            AF.request(request.rawValue, method: .delete,
                                                parameters: params,
                                                headers: headers)
                                                .response { (response) in
                    if response.error != nil {
                        complition(nil)
                    } else {
                        print("ObjectDeleted")
                        complition(response)
                    }
            }
        }
    }
}
