//
//  GetClass.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
enum Request {
    case Get
    case Post
    case Delete
}

protocol NetworkSupportProtocol:class {
    func chooseRequest(with request:Request, compliton: @escaping (Any) -> Void)
}
