//
//  NewTransactionViewController.swift
//  Billing
//
//  Created by Азизбек on 06.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol NewTransactionViewCloseProtocol: class {
    func closeAction()
}
protocol NewTransactionViewAddProtocol: class {
    
}

class NewTransactionViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "closeIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var newTransactionViewCloseDelegate: NewTransactionViewCloseProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(closeButton)
        closeButton.addConstraintsWithFormat(format: "V:|-[v0(30)]", views: closeButton)
        closeButton.addConstraintsWithFormat(format: "H:[v0(30)]-|", views: closeButton)
        closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        subView.layer.shadowOpacity = 0.3
        subView.layer.shadowRadius = 0.6
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
    }
    
    @objc private func closeTapped(_ sender: UIButton) {
        newTransactionViewCloseDelegate?.closeAction()
    }
    
}
