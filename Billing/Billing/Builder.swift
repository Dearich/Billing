//
//  Builder.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol{
    static func createMain() -> UIViewController
}

class ModuleBuilder {
    
    static func createMain() -> UIViewController {
        let view = BillingViewController()
        //создаем презентерт тоже тут 
//        let billingViewController = .....
//        view.mainPresenter = billingViewController
        return view
    }
}
