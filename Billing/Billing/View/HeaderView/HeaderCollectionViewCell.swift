//
//  HeaderCollectionViewCell.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        balanceLabel.text = "balance:123123123"
        addSubview(balanceLabel)
        balanceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        balanceLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ownerLabel.text = "Owner: Tron"
        addSubview(ownerLabel)
        ownerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        ownerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        ownerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
