//
//  BillingViewController.swift
//  Billing
//
//  Created by Азизбек on 26.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class BillingViewController: UIViewController {
    
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

        showSubviews()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    
    func showSubviews(){
        view.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        
        view.addSubview(bottomView)
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.layer.cornerRadius = 42
        bottomView.layer.masksToBounds = true
    }
    
}
extension BillingViewController: ContentOffsetYDelegate{
    func headerAnimation(_ contentOffsetY: CGFloat) {
     print(contentOffsetY)
        
    }
    
    
}
