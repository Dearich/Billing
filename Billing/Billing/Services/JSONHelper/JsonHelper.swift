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

    func parse(requestType: Request, data: AFDataResponse<Any>, completion: @escaping ([BillingModel]?, [TransactionModel]?, Error?) -> Void) {
        if data.error != nil {
            print(data.error!.localizedDescription)
            completion(nil, nil, data.error)
        } else {
            do {
                guard let unwraptedData = data.data else {return}
                switch requestType {
                case .getBilling:
                    let decodedData = try JSONDecoder().decode([BillingModel]?.self, from: unwraptedData)
                    completion(decodedData, nil, nil)
                case .getTransaction:
                    let decodedData = try JSONDecoder().decode([TransactionModel]?.self, from: unwraptedData)
                    completion(nil, decodedData, nil)
                default:

                    return
                }
            } catch {
                print("decode error")
                print(error.localizedDescription)
            }
        }
    }
}
