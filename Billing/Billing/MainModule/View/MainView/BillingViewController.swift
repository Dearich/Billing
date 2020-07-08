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
    lazy var billingPopUp: BillingPopUp = {
        let view = BillingPopUp()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.closePopUPDelegate = self
        return view
    }()
    let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.contentOffsetY = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource.deleteTransactionsDelegate = self
        return view
    }()
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subView: NewBillingView = {
        let subView = NewBillingView()
        subView.view.backgroundColor = .clear
        return subView
    }()
    let newTransactionView: NewTransactionViewController = {
        let controller = NewTransactionViewController(nibName: "NewTransactionViewController", bundle: nil)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData()
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 5
        setUpNavigationBar()
        headerView.headerViewDelegate = self
        //test
        headerView.dataSource.billingPopUpProtocol = self
        //test
        bottomView.dataSource.contentOffsetYDelegate = self
        bottomView.bottomViewAddDelegate = self
        subView.newBillingViewDelegate = self
        newTransactionView.newTransactionViewCloseDelegate = self
        print("viewDidLoad Finish")
    }
    func animationAddView() {
        addBlurEffect()
        self.addChild(subView)
        subView.view.frame = self.view.frame
        self.view.addSubview(subView.view)
        subView.didMove(toParent: self)
        subView.view.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            self.subView.view.alpha = 1.0
        }
    }
    private func addBlurEffect() {
        view.addSubview(visualEffectView)
        visualEffectView.alpha = 0
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
        }
    }
    private func showBillings() {
        view.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        let heightConstraint = headerView.heightAnchor.constraint(equalToConstant: (view.frame.height / 3.9))
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
            self.headerView.control.numberOfPages = billingArray.count
        }
    }
    func setUpBottomView(transactionArray: [TransactionModel]) {
        DispatchQueue.main.async {
            self.bottomView.dataSource.transactions = transactionArray
            self.bottomView.tableView.reloadData()
        }
    }
}

extension BillingViewController: NewBillingViewCloseProtocol {
    func close() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.subView.view.alpha = 0
        }) { [weak self] (done) in
            if done {
                self?.visualEffectView.removeFromSuperview()
                self?.subView.view.removeFromSuperview()
                self?.headerView.collectionView.reloadData()
            }
        }
    }
}
extension BillingViewController: NewTransactionViewCloseProtocol {
    func closeAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.newTransactionView.view.alpha = 0
        }) { [weak self] (bool) in
            if bool {
                self?.visualEffectView.removeFromSuperview()
                self?.newTransactionView.view.removeFromSuperview()
            }
        }
    }
}

extension BillingViewController: HeaderViewProtocol {
    func showPopUpView() {
        animationAddView()
    }
}
extension BillingViewController: BottomViewAddProtocol {
    func addTapped() {
        addBlurEffect()
        self.addChild(newTransactionView)
        newTransactionView.view.frame = self.view.frame
        self.view.addSubview(newTransactionView.view)
        newTransactionView.didMove(toParent: self)
        newTransactionView.view.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            self.newTransactionView.view.alpha = 1.0
        }
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
        } else if newHight < minHight {
            self.heightConstraint.constant = minHight
            NSLayoutConstraint.activate([self.heightConstraint])
        } else {
            self.heightConstraint.constant = newHight
            NSLayoutConstraint.activate([self.heightConstraint])
            complition(0)
        }
        let dinamicAlpha = ((self.heightConstraint.constant - presenter.headerViewMaxHeight) / minHight) + 1
        UIView.animate(withDuration: 0.25) {
            self.headerView.collectionView.alpha = dinamicAlpha
        }
    }
}
extension BillingViewController: BillingPopUpProtocol, ClosePopUPDelegate {
    
    fileprivate func haptikEngine(_ generator: UINotificationFeedbackGenerator) {
        generator.notificationOccurred(.success)
        addBlurEffect()
    }
    func showPopUp(_ billing: BillingModel) {
        let generator = UINotificationFeedbackGenerator()
        haptikEngine(generator)
        view.addSubview(billingPopUp)
        billingPopUp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        billingPopUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        billingPopUp.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        billingPopUp.widthAnchor.constraint(equalToConstant: view.frame.width / 1.2).isActive = true
        billingPopUp.transform = CGAffineTransform(scaleX: 1, y: 1)
        billingPopUp.layer.cornerRadius = 15
        
        presenter.objectForDelete = billing
        billingPopUp.balance.text = "Balance: \(billing.balance)"
        billingPopUp.owner.text = "Owner: \(billing.owner)"
        billingPopUp.dateLabel.text = stringDate(billing.date)
        UIView.animate(withDuration: 0.4) {
            self.billingPopUp.alpha = 1
            
        }
    }
    func dissmis() {
        UIView.animate(withDuration: 0.4, animations: {
            self.visualEffectView.alpha = 0
            self.billingPopUp.alpha = 0
            self.billingPopUp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.presenter.deleteObject(self.presenter.objectForDelete!) { (_) in
            }
        }) { [weak self](bool) in
            if bool {
                DispatchQueue.main.async {
                    print("reloaded")
                    self?.presenter.getData()
                    self?.headerView.collectionView.reloadData()
                }
                self?.billingPopUp.removeFromSuperview()
            }
            
        }
    }
    fileprivate func stringDate( _ date: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone(abbreviation: "MSK")
        dateFormater.locale = NSLocale.current
        dateFormater.dateFormat = "dd MMMM"
        let strDate = dateFormater.string(from: date)
        return strDate
    }
}
extension BillingViewController: DeleteTransactionsDelegate {
    func getIndexPath( _ indexPath: IndexPath, _ transaction: [TransactionModel]) {
        presenter.deleteObject(transaction[indexPath.row]) {[weak self] (done) in
            if done {
                self?.bottomView.tableView.reloadData()
            }
        }
    }
}
