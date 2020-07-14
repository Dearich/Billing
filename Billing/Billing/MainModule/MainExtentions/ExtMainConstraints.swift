//
//  ExtMainConstraints.swift
//  Billing
//
//  Created by Азизбек on 11.07.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//
// MARK: - Расширение для создания constraint -
import UIKit

extension BillingViewController {
    func addBlurEffect() {
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
    
    func showBillings() {
        view.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        let heightConstraint = headerView.heightAnchor.constraint(equalToConstant: (view.frame.height / 3.9))
        self.heightConstraint = heightConstraint
        self.heightConstraint.isActive = true
        showTransactions() 
    }
    
    func showTransactions() {
        view.addSubview(bottomView)
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.layer.masksToBounds = true
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
