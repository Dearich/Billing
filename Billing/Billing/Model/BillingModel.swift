//
//  BillingModel.swift
//  Billing
//
//  Created by Азизбек on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
struct BillingModel:Codable {

    let balance: String
    let date: Int
    let id: Int
    let owner: String
    let ownerID: Int

}
