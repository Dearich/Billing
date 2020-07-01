//
//  RequestType.swift
//  Billing
//
//  Created by Азизбек on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

enum Request: String {
    case getBilling = "https://bankaccounts-andersen.herokuapp.com/allBilling"
    case postBilling = "https://bankaccounts-andersen.herokuapp.com/newBilling"
    case deleteBilling = "https://bankaccounts-andersen.herokuapp.com/billing"

    case getTransaction = "https://bankaccounts-andersen.herokuapp.com/allTransaction"
    case postTransaction = "https://bankaccounts-andersen.herokuapp.com/newTransaction"
    case deleteTransaction = "https://bankaccounts-andersen.herokuapp.com/transaction"
}
