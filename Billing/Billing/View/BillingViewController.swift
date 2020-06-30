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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getBillings()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        print("viewDidLoad Finish")
    }
    
    
    private func showBillings(){
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
    
    func setUpHeaderView(billingArray: Billings) {
        DispatchQueue.main.async {
            self.showBillings()
            self.headerView.billingArray = billingArray
        }
    }
    
    func setUpBottomView(transactionArray: Transactions){
        DispatchQueue.main.async {
            
            self.bottomView.transactions = transactionArray
            self.bottomView.tableView.reloadData()
        }
    }
    
}
extension BillingViewController: ContentOffsetYDelegate{
    
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
