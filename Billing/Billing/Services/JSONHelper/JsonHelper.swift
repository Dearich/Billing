//
//  JsonHelper.swift
//  Billing
//
//  Created by Азизбек on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire
class JsonHelper {
    static let shared = JsonHelper()
    func parse(requestType: Request, data:AFDataResponse<Any> , completion: @escaping (Billings, Transactions, Error?) -> Void) {
        if data.error != nil {
            print(data.error!.localizedDescription)
            completion(nil, nil, data.error)
        } else {
            do {
                guard let unwraptedData = data.data else {return}
                switch requestType {
                case .GetBilling:
                    let decodedData = try JSONDecoder().decode(Billings.self, from: unwraptedData)
                    completion(decodedData, nil, nil)
                case .GetTransaction:
                    let decodedData = try JSONDecoder().decode(Transactions.self, from: unwraptedData)
                    completion(nil, decodedData, nil)
                default:
                    completion(nil, nil, nil)
                    return
                }
            } catch {
                print("decode error")
                print(error.localizedDescription)
            }
        }
    }
}
