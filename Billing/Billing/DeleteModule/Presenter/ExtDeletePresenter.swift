//
//  ExtDeletePresenter.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 14.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension DeletePresenter {
     func stringDate( _ date: Int) -> String {
          let date = Date(timeIntervalSince1970: Double(date))
          let dateFormater = DateFormatter()
          dateFormater.timeZone = TimeZone(abbreviation: "MSK")
          dateFormater.locale = NSLocale.current
          dateFormater.dateFormat = "dd MMMM"
          let strDate = dateFormater.string(from: date)
          return strDate
      }
}
