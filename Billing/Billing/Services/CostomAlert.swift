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
        case emptyField
        case gotError
    }

    convenience init(alertType: TypeOfAlert, presenter: MainPresenter? = nil, or controller: UIViewController? = nil) {
        switch alertType {
        case .lostInternet:
            self.init(title: "Отсутвует подключение!",
                      message: "Проверьте соединение с интернетом и попробуйте еще раз.",
                      preferredStyle: .actionSheet)
            let okayButton = UIAlertAction(title: "OK", style: .cancel) { (_) in
                guard let presenter = presenter else { return }
                presenter.getBillings()
            }
            self.addAction(okayButton)

        case .emptyField:

            self.init(title: "Заполните поле!",
                      message: "Заполните все поля, затем попробуйте еще раз.",
                      preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            self.addAction(okayButton)

        case .gotError:
            self.init(title: "Ошибка!",
                      message: "Ошибка сервера. Повторите позже.",
                      preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            self.addAction(okayButton)
        }
        
        if let presenter = presenter {
            presenter.view.present(self, animated: true, completion: nil)
        } else if let controller = controller {
            controller.present(self, animated: true, completion: nil)
        }
        
    }
}
