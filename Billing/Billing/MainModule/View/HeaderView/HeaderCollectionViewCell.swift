//
//  HeaderCollectionViewCell.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol ShowPopUpViewProtocol: class {
    func animationAddView()
    func animationDeleteView(billing: BillingModel?)
    var deleteView: DeleteViewController? { get }
}

class HeaderCollectionViewCell: UICollectionViewCell {
    var cellBilling: BillingModel?
    
    var billing: Any?
    weak var showPopUpViewDelegate: ShowPopUpViewProtocol?
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 1, alpha: 1)
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()

    let ownerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 80, height: 80)
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4156862745, blue: 0.5843137255, alpha: 1)
        contentView.layer.cornerRadius = 10
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                        action: #selector(longPressGestureTapped(_:)))
        //shadow
        let shadowSize: CGFloat = 7
        let contactRect = CGRect(x: -shadowSize,
                                 y: contentView.bounds.height - (shadowSize * 0.4),
                                 width: contentView.bounds.width + shadowSize * 2,
                                 height: shadowSize)
        contentView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 1
        contentView.addGestureRecognizer(longPressGestureRecognizer)
        if billing is BillingModel {
            guard let bill = billing as? BillingModel else { return }
            
            addSubview(balanceLabel)
            balanceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
            balanceLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            balanceLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            balanceLabel.text = bill.balance
            
            addSubview(ownerLabel)
            ownerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
            ownerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
            ownerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            ownerLabel.text = bill.owner
        } else if  billing is PlusModel {
            addSubview(addButton)
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
        }
    }

    @objc func addTapped(_ sender: UIButton) {
        showPopUpViewDelegate?.animationAddView()
    }
    
    @objc func longPressGestureTapped(_ gesture: UIGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            if billing is BillingModel {
                showPopUpViewDelegate?.animationDeleteView(billing: billing as? BillingModel)
            }
        default:
            return
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addButton.removeFromSuperview()
        balanceLabel.removeFromSuperview()
        ownerLabel.removeFromSuperview()
    }
    
}
