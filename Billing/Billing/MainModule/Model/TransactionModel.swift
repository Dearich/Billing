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
    let id: Int
    let ownerID: Int
    let sum: Int
    let title: String
    init(date:Int, icon:String, id: Int, ownerID:Int, sum: Int, title:String) {
        self.date = date
        self.icon = icon
        self.id = id
        self.ownerID = ownerID
        self.sum = sum
        self.title = title
    }
}
typealias Billings = [BillingModel]?
typealias Transactions = [TransactionModel]?
