//
//  BottomView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol ContentOffsetYDelegate {
    func headerAnimation(_ contentOffsetY: CGFloat)
}

class BottomView: UIView {
    
    var contentOffsetY: ContentOffsetYDelegate!
    
    lazy var tableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        backgroundColor = .white
        
        addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BottomView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetY.headerAnimation(scrollView.contentOffset.y)
        
    }
    
    
}
