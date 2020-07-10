//
//  NewTransactionViewController.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController {

    var presenter: NewTransactionPresenter!
    var billingViewController: BillingViewController?
    
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(closeAction))
        closeGestureRecognizer.direction = .init(arrayLiteral: [.down, .up])
        self.view.addGestureRecognizer(closeGestureRecognizer)
    }
    
    @objc func closeAction() {
        close(billingViewController: billingViewController, view: self.view)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        //TODO проверка полей на заполнение
        presenter.saveTransaction()
        close(billingViewController: billingViewController, view: self.view)
    }
}
