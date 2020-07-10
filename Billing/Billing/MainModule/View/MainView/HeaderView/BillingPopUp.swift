//
//  BillingPopUp.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 02.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol ClosePopUPDelegate: class {
    func deleteButtonPressed()
}

class BillingPopUp: UIView {
    weak var closePopUPDelegate: ClosePopUPDelegate?
    var billingData: [BillingModel]?
    // MARK: - Balance Label
    let balance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Balance: 0"
        return label
    }()
    // MARK: - Owner Label
    let owner: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.text = "Owner: Tron"
        return label
    }()
    // MARK: - Delete button
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDissmis), for: .touchUpInside)
        return button
    }()
    // MARK: - Date Label
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "00 - 00 - 00"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4156862745, blue: 0.5843137255, alpha: 1)
        addSubview(balance)
        balance.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        balance.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        addSubview(deleteButton)
        deleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        addSubview(owner)
        owner.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        owner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        addSubview(dateLabel)
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        dateLabel.topAnchor.constraint(equalTo: owner.bottomAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleDissmis() {
        closePopUPDelegate?.deleteButtonPressed()
    }
}
