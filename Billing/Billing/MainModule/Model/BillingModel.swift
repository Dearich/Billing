//
//  BillingModel.swift
//  Billing
//
//  Created by Азизбек on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
struct BillingModel: Codable {

    let balance: String
    let date: Int
    let id: Int
    let owner: String
    let ownerID: Int

    init(balance: String, date: Int, id: Int, owner: String, ownerID: Int) {
        self.balance = balance
        self.date = date
        self.id = id
        self.owner = owner
        self.ownerID = ownerID
    }

    func convertToDic() -> [String: Any] {

        return ["balance" :  balance,
                "date"    :  date,
                "id"      :  id,
                "owner"   :  owner,
                "ownerID" :  ownerID]
    }
}
