//
//  BottomView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol BottomViewAddProtocol: class {
    func addTapped()
}

protocol ContentOffsetYDelegate: class {
    func headerAnimation(contentOffsetY: CGFloat, complition: @escaping ((CGFloat) -> Void))
}
class BottomView: UIView {
    
    var contentOffsetY: ContentOffsetYProtocol!
    var transactions: [TransactionModel] = []
    weak var bottomViewAddDelegate: BottomViewAddProtocol?
    
    lazy var dataSource: ButtomDataSource = {
        let dataSource = ButtomDataSource()
        return dataSource
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self.dataSource
        view.dataSource = self.dataSource
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - init tableView on SubView
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(BottomTableViewCell.self, forCellReuseIdentifier: "TableCell")
        backgroundColor = .white
        
        addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.addConstraintsWithFormat(format: "V:|-20-[v0]-|", views: tableView)
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        addSubview(addButton)
        addButton.addConstraintsWithFormat(format: "V:|-[v0(35)]", views: addButton)
        addButton.addConstraintsWithFormat(format: "H:[v0(35)]-|", views: addButton)
        addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addTapped(_ sender: UIButton) {
        if sender == addButton {
            print("addTapped")
            bottomViewAddDelegate?.addTapped()
            
        }
    }
}
