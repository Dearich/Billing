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
    }

    func getBillings() {
        print("getBillings")
        let disposeBag = DisposeBag()
        setUpProgressView()
        getClass.chooseRequest(with: .GetBilling) {[weak self] (response) in
            _ = Observable.just(response)
                .subscribe(onNext: { (response) in
                     self?.view.setUpHeaderView(billingArray: response as! Billings)
                }, onError: { (error) in
                    print(error.localizedDescription)
                })
                .disposed(by: disposeBag)
        }
        getClass.chooseRequest(with: .GetTransaction) { [weak self] (transactions) in
            _ = Observable.just(transactions)
                .subscribe(onNext: { (response) in
                   self?.view.setUpBottomView(transactionArray: transactions as! Transactions)
                }, onError: { (error) in
                    print(error.localizedDescription)
                })
                .disposed(by: disposeBag)
        }
    }
    private func setUpProgressView() {
        if CheckInternetConnection.Connection(){
            DispatchQueue.main.async {
                self.headerViewMaxHeight = self.view.view.frame.height / 4
                let progress = Progress(totalUnitCount: 10)
                self.view.progressView.progress = 0.0
                progress.completedUnitCount = 0
                for _ in 0...10 {
                    progress.completedUnitCount += 1
                    self.view.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Отсутвует подключение!", message: "Проверьте соединение с интернетом и попробуйте еще раз", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "OK", style: .cancel) {[weak self] (action) in
                self?.getBillings()
            }
            alert.addAction(action)
            view.present(alert, animated: true, completion: nil)
        }
    }
}
