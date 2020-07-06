//
//  BillingViewController.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import RxSwift

class BillingViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    var presenter: Presenter!
    var heightConstraint: NSLayoutConstraint!
    lazy var billingPopUp: BillingPopUp = {
        let view = BillingPopUp()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.closePopUPDelegate = self
        view.billingData = presenter.getBillingForPopUp
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
        view.deleteTransactionsDelegate = self
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
        headerView.showBillingPopUp = self
        print("viewDidLoad Finish")
    }
    func animationAddView() {
        //        TODO: 1)добавить view для добавления новых billing
        //                2) отрабоать исчезновение blur эффетка
        //                3) Создать класс сохранения и вызывать метод после закрытия окна
        //                4) Получать новый список с сервера
        //                4) Обновлять collection
        //
        //                        addBlurEffect()
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
            self.headerView.billingArray = billingArray
            self.headerView.billingArray.append(plus)
        }
    }
    func setUpBottomView(transactionArray: [TransactionModel]) {
        DispatchQueue.main.async {
            self.bottomView.transactions = transactionArray
            self.bottomView.tableView.reloadData()
        }
    }
    @IBAction func doneButton(_ sender: UIButton) {
    }
}

extension BillingViewController: HeaderViewProtocol {
    func showPopUpView() {
        //        animationAddView()
    }
}

extension BillingViewController: ContentOffsetYDelegate {
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

extension BillingViewController: ShowBillingPopUP,ClosePopUPDelegate {
    fileprivate func haptikEngine(_ generator: UINotificationFeedbackGenerator) {
        generator.notificationOccurred(.success)
        addBlurEffect()
    }
    func showPopUP(indexPath: IndexPath) {
        let generator = UINotificationFeedbackGenerator()
        haptikEngine(generator)
        view.addSubview(billingPopUp)
        billingPopUp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        billingPopUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        billingPopUp.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        billingPopUp.widthAnchor.constraint(equalToConstant: view.frame.width / 1.2).isActive = true
        billingPopUp.transform = CGAffineTransform(scaleX: 1, y: 1)
        billingPopUp.layer.cornerRadius = 15
        guard let billing = billingPopUp.billingData?[indexPath.row] else {return}
        billingPopUp.balance.text = "Balance: \(billing.balance)"
        billingPopUp.owner.text = "Owner: \(billing.owner)"
        billingPopUp.dateLabel.text = stringDate(billing.date)
        presenter.objectForDelete = billing
        //TODO: Индекс становится не верным после первого удаления, но при этом после удаления с конца, все ок!
        UIView.animate(withDuration: 0.4) {
            self.billingPopUp.alpha = 1
        }
    }
    func dissmis() {
        UIView.animate(withDuration: 0.4, animations: {
            self.visualEffectView.alpha = 0
            self.billingPopUp.alpha = 0
            self.billingPopUp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.presenter.deleteObject(self.presenter.objectForDelete!) { (_) in}
        }) { [weak self](_) in
                print("Reload Data")
                self?.headerView.collectionView.reloadData()
            self?.billingPopUp.removeFromSuperview()
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
