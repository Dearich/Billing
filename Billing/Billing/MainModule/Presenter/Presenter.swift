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

protocol PresenterProtocol: ObjectForDeleteProtocol {
    var view: UIViewController { get }
    var objectForDelete: Any? {get set}
    func getData()
}

class Presenter: PresenterProtocol {
    let view: UIViewController
    //    let view: BillingViewController
    lazy var getClass = GetClass()
    var headerViewMaxHeight: CGFloat = 0.0
    var objectForDelete: Any?
    let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    required init(view: BillingViewController) {
        self.view = view
    }
    func getData() {
        let disposeBag = DisposeBag()
        setUpProgressView()
        guard let view  = view as? BillingViewController else { return }
        view.subView.addNewBillingDelegate = self
        getClass.chooseRequest(with: .getBilling) {(response) in
            if response is [BillingModel] {
                _ = Observable.just(response)
                    .subscribe(onNext: { (response) in
                        guard let response = response as? [BillingModel] else { return }
                        view.setUpHeaderView(billingArray: response)
                    }, onError: { (error) in
                        print(error.localizedDescription)
                    })
                    .disposed(by: disposeBag)
            }
        }
        getClass.chooseRequest(with: .getTransaction) { (transactions) in
            if transactions is [TransactionModel] {
                _ = Observable.just(transactions)
                    .subscribe(onNext: { (_) in
                        guard let transactions = transactions as? [TransactionModel] else { return }
                        view.setUpBottomView(transactionArray: transactions)
                    }, onError: { (error) in
                        print(error.localizedDescription)
                    })
                    .disposed(by: disposeBag)
            }
        }
    }
    private func setUpProgressView() {
        guard let view  = view as? BillingViewController else { return }
        if CheckInternetConnection.Connection() {
            DispatchQueue.main.async {
                self.headerViewMaxHeight = self.view.view.frame.height / 4
                let progress = Progress(totalUnitCount: 10)
                view.progressView.progress = 0.0
                progress.completedUnitCount = 0
                for _ in 0...10 {
                    progress.completedUnitCount += 1
                    view.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                }
            }
        } else {
            _ = UIAlertController(alertType: .lostInternet, presenter: self)
        }
    }
    func deleteObject(_ object: Any, complition: @escaping (Bool) -> Void) {
        let deleteClass = DeleteClass(objectForDelete: object)
        deleteClass.chooseRequest(with: .deleteBilling) { (response) in
            if response as? Bool == true {
                    self.getData()
                complition(true)
            } else {
                complition(false)
            }
        }
        deleteClass.chooseRequest(with: .deleteTransaction) { (response) in
            if response as? Bool == true {
                    self.getData()
                complition(true)
            } else {
                complition(false)
            }
        }
    }
}

extension Presenter:AddNewBillingProtocol {
    func addNewBillingAndUpdate(balance: String, complition: @escaping ((Bool) -> Void)) {
        let timestamp = Date().timeIntervalSince1970
        let ownerID = 1
        let savingObj = NewBilling(balance: balance, date: Int(timestamp), ownerID: ownerID)
        let post = PostClass(savingObject: savingObj)
        post.chooseRequest(with: .postBilling) {[weak self] (response) in
            if response == nil {
                complition(false)
            }
            complition(true)
            self?.getData()
        }
       
    }
}
