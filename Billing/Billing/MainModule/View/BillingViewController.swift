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

    @IBOutlet weak var progressView: UIProgressView!

    var presenter: Presenter!
    var heightConstraint: NSLayoutConstraint!

    let headerView: HeaderView = {
        let view = HeaderView()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData()
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 5
        setUpNavigationBar()
        headerView.headerViewDelegate = self
        bottomView.dataSource.contentOffsetYDelegate = self
        print("viewDidLoad Finish")
    }

    func animationAddView() {

        /*TODO: 1)добавить view для добавления новых billing
                2) отрабоать исчезновение blur эффетка
                3) Создать класс сохранения и вызывать метод после закрытия окна
                4) Получать новый список с сервера
                4) Обновлять collection
         */
//        addBlurEffect()

    }

    private func addBlurEffect() {
        view.addSubview(visualEffectView)
        visualEffectView.alpha = 0
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
        }
    }

    private func showBillings() {
        view.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        let heightConstraint = headerView.heightAnchor.constraint(equalToConstant: (view.frame.height / 4))
        self.heightConstraint = heightConstraint
        self.heightConstraint.isActive = true
        showTransactions()
    }
    private func showTransactions() {
        view.addSubview(bottomView)
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.layer.masksToBounds = true
    }

    private func setUpNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    func setUpHeaderView(billingArray: [BillingModel]) {
        DispatchQueue.main.async {
            self.showBillings()
            let plus = PlusModel()
            var billingArray: [Any] = billingArray
            billingArray.append(plus)
            self.headerView.dataSource.billingArray = billingArray
        }
    }

    func setUpBottomView(transactionArray: [TransactionModel]) {
        DispatchQueue.main.async {
            self.bottomView.dataSource.transactions = transactionArray
            self.bottomView.tableView.reloadData()
        }
    }
}

extension BillingViewController: HeaderViewProtocol {
    func showPopUpView() {
        animationAddView()
    }
}

extension BillingViewController: ContentOffsetYProtocol {

    func headerAnimation(contentOffsetY: CGFloat, complition: @escaping ((CGFloat) -> Void)) {
        let minHight = presenter.statusBarHeight + 30
        let newHight = (self.heightConstraint.constant) - contentOffsetY

        self.heightConstraint.isActive = false

        if newHight > presenter.headerViewMaxHeight {

            self.heightConstraint.constant = presenter.headerViewMaxHeight
            NSLayoutConstraint.activate([self.heightConstraint])
            print("newHight > presenter.headerViewMaxHeight: \(self.heightConstraint.constant)")

        } else if newHight < minHight {

            self.heightConstraint.constant = minHight
            NSLayoutConstraint.activate([self.heightConstraint])
            print("newHight < minHight: \(self.heightConstraint.constant)")
        } else {
            self.heightConstraint.constant = newHight
            NSLayoutConstraint.activate([self.heightConstraint])
            print("newHight: \(self.heightConstraint.constant)")
            complition(0)
        }
        let dinamicAlpha = ((self.heightConstraint.constant - presenter.headerViewMaxHeight) / minHight) + 1

        UIView.animate(withDuration: 0.25) {
            self.headerView.collectionView.alpha = dinamicAlpha
        }
    }

}
