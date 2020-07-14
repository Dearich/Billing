//
//  BillingViewController.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class BillingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: MainPresenter!
    var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Основные элементы интерфейса -
    var deleteView: DeleteViewController?
    let headerView: HeaderCollectionView = {
        let view = HeaderCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.contentOffsetY = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newBillingView : NewBillingView = {
        let subView = NewBillingView()
        subView.view.backgroundColor = .clear
        return subView
    }()
    
    let newTransactionView: NewTransactionViewController = {
        let view = ModuleBuilder.createTransaction()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        headerView.headerViewDelegate = self
        bottomView.dataSource.contentOffsetYDelegate = self
        bottomView.bottomViewDelegate = self
        newBillingView.newBillingViewDelegate = self
        presenter.getBillings()
        presenter.getTransaction()
        deleteView?.presenter.collectionView = headerView.collectionView
        newTransactionView.billingViewController = self
    }
    
    func animationAddView() {
        addBlurEffect()
        self.addChild(newBillingView)
        newBillingView.view.frame = self.view.frame
        self.view.addSubview(newBillingView.view)
        newBillingView.didMove(toParent: self)
        newBillingView.becomeFirstResponder()
        newBillingView.view.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            self.newBillingView.view.alpha = 1.0
        }
    }
    
    func setUpHeaderView(billingArray: [Any]?) {
        let plus = PlusModel()
        guard var localBillingArray = billingArray else { return }
        localBillingArray.append(plus)
        headerView.dataSource.billingArray = localBillingArray
        headerView.collectionView.reloadData()
        showBillings()
        self.headerView.control.numberOfPages = localBillingArray.count
    }
    
    func setUpBottomView(transactionArray: [TransactionModel]?) {
        guard let transactions = transactionArray else { return }
        self.bottomView.dataSource.transactions = transactions
        self.bottomView.tableView.reloadData()
    }
}
