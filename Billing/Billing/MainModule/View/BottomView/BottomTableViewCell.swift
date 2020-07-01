//
//  BottomTableViewCell.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 28.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class BottomTableViewCell: UITableViewCell {

    var transaction: Any?

    let imageCategory: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    let dateLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.textColor = UIColor.label
          label.numberOfLines = 2
          label.font = .systemFont(ofSize: 12, weight: .medium)
          return label
      }()

    let costLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.textColor = UIColor.label
          label.numberOfLines = 2
          label.font = .systemFont(ofSize: 18, weight: .medium)
          return label
      }()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(imageCategory)
        if transaction is TransactionModel {
            guard let trans = transaction as? TransactionModel else { return }
            imageCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            imageCategory.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            imageCategory.heightAnchor.constraint(equalToConstant: bounds.height * 0.9).isActive = true
            imageCategory.widthAnchor.constraint(equalToConstant: bounds.height * 0.9).isActive = true
            imageCategory.backgroundColor = #colorLiteral(red: 0.4432988763, green: 0.4114077091, blue: 0.5818795562, alpha: 1)
            imageCategory.layer.masksToBounds = true
            imageCategory.layer.cornerRadius = 30
            imageCategory.image = UIImage(named: trans.icon)
            imageView?.contentMode = .scaleAspectFit

            addSubview(categoryLabel)
            categoryLabel.leftAnchor.constraint(equalTo: imageCategory.rightAnchor, constant: 20).isActive = true
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 5).isActive = true
            categoryLabel.text = trans.title

            addSubview(dateLabel)
            dateLabel.leftAnchor.constraint(equalTo: imageCategory.rightAnchor, constant: 20).isActive = true
            dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true

            let date = Date(timeIntervalSince1970: Double(trans.date))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
            let localDate = dateFormatter.string(from: date)

            dateLabel.text = "\(localDate)"

            addSubview(costLabel)
            costLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
            costLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            costLabel.text = "\(trans.sum)"
        } else {
            //другой вид ячейки
        }
    }
    override func prepareForReuse() {

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
