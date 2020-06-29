//
//  BottomTableViewCell.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class BottomTableViewCell: UITableViewCell {
    
    let imageCategory: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    let dateLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.textColor = .black
          label.numberOfLines = 2
          label.font = .systemFont(ofSize: 12, weight: .medium)
          return label
      }()
    
    let costLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.textColor = .black
          label.numberOfLines = 2
          label.font = .systemFont(ofSize: 18, weight: .medium)
          return label
      }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(imageCategory)
        imageCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imageCategory.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageCategory.heightAnchor.constraint(equalToConstant: bounds.height / 1.5).isActive = true
        imageCategory.widthAnchor.constraint(equalToConstant: bounds.height / 1.5).isActive = true
        
        addSubview(categoryLabel)
        categoryLabel.leftAnchor.constraint(equalTo: imageCategory.rightAnchor, constant: 20).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 5).isActive = true
        
        addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: imageCategory.rightAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true
        
        addSubview(costLabel)
        costLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        costLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
