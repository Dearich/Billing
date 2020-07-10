//
//  ButtomDataSource.swift
//  Billing
//
//  Created by Азизбек on 01.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

protocol ContentOffsetYProtocol: class {
    func headerAnimation(contentOffsetY: CGFloat, complition: @escaping ((CGFloat) -> Void))
}

class ButtomDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var transactions: [TransactionModel] = []
    weak var contentOffsetYDelegate: ContentOffsetYProtocol?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return transactions.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? BottomTableViewCell
            else { return UITableViewCell() }

           cell.transaction = transactions[indexPath.row]
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetYDelegate?.headerAnimation(contentOffsetY: scrollView.contentOffset.y) { (contentOffset) in
        scrollView.contentOffset.y = contentOffset
        }  // для анимации хедера
    }

}
