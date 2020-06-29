//
//  RequestType.swift
//  Billing
//
//  Created by Азизбек on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

enum Request: String {
    case GetBilling = "https://bankaccounts-andersen.herokuapp.com/allBilling"
    case PostBilling = "https://bankaccounts-andersen.herokuapp.com/newBilling"
    case DeleteBilling = "https://bankaccounts-andersen.herokuapp.com/billing"
    
    case GetTransaction = "https://bankaccounts-andersen.herokuapp.com/allTransaction"
    case PostTransaction = "https://bankaccounts-andersen.herokuapp.com/newTransaction"
    case DeleteTransaction = "https://bankaccounts-andersen.herokuapp.com/transaction"
}
