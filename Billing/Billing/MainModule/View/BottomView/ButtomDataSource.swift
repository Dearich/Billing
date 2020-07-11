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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell",
                                                       for: indexPath) as? BottomTableViewCell
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let correntTransaction = transactions[indexPath.row]
            print(correntTransaction.id)
            DeleteClass.shared.deleteTransactionwith(request: .deleteTransaction,
                                                     objectForDelete: correntTransaction) { [weak self] (response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let response = response {
                    print(response)
                    self?.transactions.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                    }
                }
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetYDelegate?.headerAnimation(contentOffsetY: scrollView.contentOffset.y) { (contentOffset) in
        scrollView.contentOffset.y = contentOffset
        }  // для анимации хедера
    }
}
