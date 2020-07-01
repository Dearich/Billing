//
//  CostomAlert.swift
//  Billing
//
//  Created by Азизбек on 01.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension UIAlertController {
    enum TypeOfAlert {
        case lostInternet
    }

    convenience init(alertType: TypeOfAlert, presenter: PresenterProtocol) {
           switch alertType {
           case .lostInternet:
             self.init(title: "Отсутвует подключение!", message: "Проверьте соединение с интернетом и попробуйте еще раз.", preferredStyle: .actionSheet)
           }
        let okayButton = UIAlertAction(title: "OK", style: .cancel) { (_) in
            presenter.getData()
        }
            self.addAction(okayButton)
            presenter.view.present(self, animated: true, completion: nil)
       }
}
