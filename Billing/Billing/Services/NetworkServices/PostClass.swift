//
//  PostClass.swift
//  Billing
//
//  Created by Азизбек on 02.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

/*TODO:
1) Дописать метод добавления новых элементов
2) Создать всплывающие окна для создания новых элементов
3) Протоколы для передачи данных из всплывающих окон в presenter для сохранения на сервере

 */

class PostClass: NetworkSupportProtocol {

    let savingObject: Any

    init(savingObject: Any) {
        self.savingObject = savingObject
    }
    func chooseRequest(with request: Request, compliton: @escaping (Any?) -> Void) {
        switch request {
        case .postBilling:
            if savingObject is BillingModel {
                guard let billing = savingObject as? BillingModel else { return }
                let parameters = billing.convertToDic()
            }
//      case .postTransaction:
        default:
            return
        }
    }
}
