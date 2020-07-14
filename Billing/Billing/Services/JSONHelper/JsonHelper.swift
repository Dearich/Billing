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
    
// MARK: - Parse to  Billing Model
    func parseBilling(with data: AFDataResponse<Any>,
                      completion: @escaping ([BillingModel]?, Error?) -> Void) {
        if data.error != nil {
            completion(nil, data.error)
        } else {
            do {
                guard let unwraptedData = data.data else { return }
                let decodedData = try JSONDecoder().decode([BillingModel]?.self, from: unwraptedData)
                completion(decodedData, nil)
            } catch {
                print("decode error")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }

// MARK: - Parse to  Transaction Model
    func parseTransaction( data: AFDataResponse<Any>,
                           completion: @escaping ( [TransactionModel]?, Error?) -> Void) {
        if data.error != nil {
            completion( nil, data.error )
        } else {
            do {
                guard let unwraptedData = data.data else {return}
                
                let decodedData = try JSONDecoder().decode([TransactionModel]?.self, from: unwraptedData)
                completion( decodedData, nil )
            } catch {
                print("decode error")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
