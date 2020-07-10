//
//  DeleteClass.swift
//  Billing
//
//  Created by Азизбек on 10.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

class DeleteClass {
    static let shared = DeleteClass()
    // MARK: - Delete Billings
    func deleteBilling(with request: Request, objectForDelete: BillingModel?,
                       complition: @escaping(_ done: Data?, Error?) -> Void) {
        guard let billing = objectForDelete else {return}
        let headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        let params = ["id": billing.id]
        AF.request(request.rawValue, method: .delete,
                   parameters: params,
                   headers: headers)
            .response { (response) in
                if response.error != nil {
                    complition(nil, response.error)
                } else {
                    print("ObjectDeleted")
                    complition(response.data,nil)
                }
        }
    }
}
