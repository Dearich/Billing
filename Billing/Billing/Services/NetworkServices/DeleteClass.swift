//
//  DeleteClass.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 01.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

class DeleteClass{
    
    var objectForDelete: Any
    
    init(objectForDelete: Any) {
        self.objectForDelete = objectForDelete
    }
    
    
    func chooseRequest(with request: Request, compliton: @escaping (Any?) -> Void) {
        switch request {
        case .DeleteBilling:
            if objectForDelete is BillingModel{
                AF.request(request.rawValue, method: .delete).response { (responce) in
                    guard responce.error == nil else {
                        print("error with Billing DELETE")
                        if let error = responce.error {
                            print("Error: \(error)")
                            compliton(false)
                        }
                        return
                    }
                    print("Billing deleted")
                    compliton(true)
                }
            }else{
                compliton(false)
            }
            
            
            
        case .DeleteTransaction:
            if objectForDelete is TransactionModel{
                AF.request(request.rawValue, method: .delete).response { (responce) in
                    guard responce.error == nil else {
                        print("error with Transaction DELETE ")
                        if let error = responce.error {
                            print("Error: \(error)")
                            compliton(false)
                        }
                        return
                    }
                    print("Transaction deleted")
                    compliton(true)
                }
            }else{
                compliton(false)
            }
            
        default:
            return
        }
    }
}
