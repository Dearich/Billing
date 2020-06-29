//
//  BottomView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol ContentOffsetYDelegate {
    func headerAnimation(contentOffsetY: CGFloat)
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
    
    //MARK:-init tableView on SubView
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(BottomTableViewCell.self, forCellReuseIdentifier: "TableCell")
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

//MARK:-TableViewDelegate and TableViewDataSource

extension BottomView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! BottomTableViewCell
        //Тестовый вариант для прорверки
        cell.imageCategory.image = UIImage(named: "shop")
        cell.categoryLabel.text = "Shopping"
        cell.dateLabel.text = "23 июня 14:56"
        cell.costLabel.text = "1000"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return bounds.height / 8
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetY.headerAnimation(contentOffsetY: -scrollView.contentOffset.y) // для анимации хедера
    }
    
    
}
