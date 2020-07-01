//
//  GetClass.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkSupportProtocol: class {
    func chooseRequest(with request: Request, compliton: @escaping (Any?) -> Void)
}

class GetClass: NetworkSupportProtocol {

    func chooseRequest(with request: Request, compliton: @escaping (Any?) -> Void) {
        let backgroundQueue = DispatchQueue(label: "azizbek.ru/backgroundTask", qos: .background, attributes: .concurrent)
        switch request {
        case .getBilling:
            AF.request(request.rawValue).responseJSON(queue: backgroundQueue) { (response) in
                JsonHelper.shared.parse(requestType: .getBilling, data: response) { (billings, transactions, error) in
                    guard error == nil else { print(error!.localizedDescription); return }
                    guard transactions == nil else {return}
                    guard billings != nil else { return }
                    compliton(billings)
                }
            }
        case .getTransaction:
            AF.request(request.rawValue).responseJSON { (response) in
                JsonHelper.shared.parse(requestType: .getTransaction, data: response) { (billings, transactions, error) in
                    guard error == nil else { print(error!.localizedDescription); return }
                    guard billings == nil else {return}
                    guard transactions != nil else { return }
                    compliton(transactions)
                }
            }
        default:
            return
        }
    }
}
