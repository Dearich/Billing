//
//  Builder.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createMain() -> UIViewController
}

class ModuleBuilder {
    static func createMain() -> UIViewController {
        let view = BillingViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }

    static func createDelete() -> DeleteViewController {
        let view = DeleteViewController(nibName: "DeleteViewController", bundle: nil)
        let presenter = DeletePresenter(view: view)
        view.presenter = presenter
        return view
    }

    static func createTransaction() -> NewTransactionViewController {
        let view = NewTransactionViewController(nibName: "NewTransactionViewController", bundle: nil)
        let presenter = NewTransactionPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
