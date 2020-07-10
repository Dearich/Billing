//
//  DeleteViewController.swift
//  Billing
//
//  Created by Азизбек on 10.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {

    @IBOutlet weak var deleteSubView: UIView!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var presenter: DeletePresenter!
    var billingViewController: BillingViewController?
    var cellBilling: BillingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(closeAction))
        closeGestureRecognizer.direction = .init(arrayLiteral: [.down, .up])
        self.view.addGestureRecognizer(closeGestureRecognizer)
        presenter.setUpDeleteView()
    }
    @objc func closeAction() {
       close()
    }

    private func close() {
        guard let billingViewController = self.billingViewController else { return }
        UIView.animate(withDuration: 0.3, animations: {
            billingViewController.visualEffectView.alpha = 0
            billingViewController.deleteView?.view.alpha = 0
        })
        
        billingViewController.visualEffectView.removeFromSuperview()
        view.removeFromSuperview()

    }
    @IBAction func deleteAction(_ sender: Any) {
        presenter.deleteBilling()
        print("deleted")
        close()
        
    }
}
