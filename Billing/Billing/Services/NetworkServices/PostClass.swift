//
//  PostClass.swift
//  Billing
//
//  Created by Азизбек on 02.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

class PostClass: NetworkSupportProtocol {

    let savingObject: Any

    init(savingObject: Any) {
        self.savingObject = savingObject
    }
    func chooseRequest(with request: Request, compliton: @escaping (Any?) -> Void) {

        switch request {
        case .postBilling:
            if savingObject is NewBilling {

                guard let billing = savingObject as? NewBilling else { return }
                guard let url = URL(string: request.rawValue) else {return}
                let headers : [String: String] = ["Content-Type":"application/x-www-form-urlencoded"]
                var httpBody = URLComponents()

                httpBody.queryItems = [URLQueryItem(name: "balance", value: "\(billing.balance)"),
                                       URLQueryItem(name: "date", value: "\(billing.date)"),
                                       URLQueryItem(name: "ownerID", value: "\(billing.ownerID)")]

                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                urlRequest.allHTTPHeaderFields = headers
                urlRequest.httpBody = httpBody.query?.data(using: .utf8)
                
                let session = URLSession.shared
                session.dataTask(with: urlRequest) { (_, response, error) in
                    if let response = response {
                        compliton(response)
                    }
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                }.resume()

            }
        case .postTransaction:
            if savingObject is TransactionModel {
                guard let transaction = savingObject as? TransactionModel else { return }

                let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

                let parameters = ["date": "\(transaction.date)",
                                        "icon": "\(transaction.icon)",
                                        "ownerID": "\(transaction.ownerID)",
                                        "sum": "\(transaction.sum)",
                                        "title": "\(transaction.title)"]
                AF.request(request.rawValue,method: .post,
                           parameters: parameters,
                           headers:headers).response { (response) in
                    compliton(response)
                }
            }
        default:
            return
        }
    }
}
