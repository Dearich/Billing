//
//  TransactionModel.swift
//  Billing
//
//  Created by Азизбек on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
struct TransactionModel: Codable {
    let date: Int
    let icon: String
    let ownerID: Int
    let sum: Int
    let title: String
}

typealias Billings = [BillingModel]?
typealias Transactions = [TransactionModel]?
