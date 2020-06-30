//
//  Presenter.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class Presenter  {

    let view: BillingViewController
    let getClass = GetClass()
    
    var headerViewMaxHeight: CGFloat = 0.0
    let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    required init(view: BillingViewController) {
        self.view = view
//        headerViewMaxHeight = view.view.frame.height / 4
    }

    func getBillings() {
        print("getBillings")
        let disposeBag = DisposeBag()
        getClass.chooseRequest(with: .GetBilling) {[weak self] (response) in
            
            _ = Observable.just(response)
                .subscribe(onNext: { (response) in
                    DispatchQueue.main.async {
                        self?.headerViewMaxHeight = self!.view.view.frame.height / 4
                    }
                    self?.view.setUpHeaderView(billingArray: response as! Billings)
                    print("setUpHeaderView")
                }, onError: { (error) in
                    print(error.localizedDescription)
                })
            .disposed(by: disposeBag)
        }
        getClass.chooseRequest(with: .GetTransaction) { (transactions) in
            
            _ = Observable.just(transactions)
                          .subscribe(onNext: { (response) in
                              self.view.setUpBottomView(transactionArray: transactions as! Transactions)
                              print("setUpButtomView")
                          }, onError: { (error) in
                              print(error.localizedDescription)
                          })
                      .disposed(by: disposeBag)
            
            
        }
    }
}
