//
//  NewBillingView.swift
//  Billing
//
//  Created by Азизбек on 02.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol NewBillingViewCloseProtocol:class {
    func close()
}
protocol AddNewBillingProtocol:class {
    func addNewBillingAndUpdate(balance:String, complition: @escaping ((Bool) -> Void))
}

class NewBillingView: UIViewController {

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "closeIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая карта"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var balanceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Желаемый баланс"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()

    weak var newBillingViewDelegate: NewBillingViewCloseProtocol?
    weak var addNewBillingDelegate: AddNewBillingProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(closeButton)
        closeButton.addConstraintsWithFormat(format: "V:|-[v0(30)]", views: closeButton)
        closeButton.addConstraintsWithFormat(format: "H:[v0(30)]-|", views: closeButton)
        closeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        view.addSubview(subView)
        subView.addConstraintsWithFormat(format: "V:|-150-[v0(210)]", views: subView)
        subView.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: subView)
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        subView.layer.shadowOpacity = 0.3
        subView.layer.shadowRadius = 0.6
        
        subView.addSubview(topLabel)
        topLabel.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: topLabel)
        subView.addSubview(balanceTextField)
        balanceTextField.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: balanceTextField)
        subView.addSubview(doneButton)
        doneButton.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: doneButton)
        topLabel.addConstraintsWithFormat(format: "V:|-20-[v0(50)]-20-[v1(40)]-20-[v2(40)]-20-|",
                                          views: topLabel, balanceTextField,doneButton)
        doneButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == closeButton {
            newBillingViewDelegate?.close()
        } else if sender == doneButton {
            guard let text = balanceTextField.text, !text.isEmpty else {
                _ = UIAlertController(alertType: .emptyField, or: self)
                return
            }
            addNewBillingDelegate?.addNewBillingAndUpdate(balance: text, complition: {[weak self] (bool) in
                if bool {
                    DispatchQueue.main.async {
                        self?.newBillingViewDelegate?.close()
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        _ = UIAlertController(alertType: .gotError, or: self)
                    }
                }
            })
        }
    }
}
