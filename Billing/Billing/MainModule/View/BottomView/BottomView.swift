//
//  BottomView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol ContentOffsetYDelegate: class {
    func headerAnimation(contentOffsetY: CGFloat, complition: @escaping ((CGFloat) -> Void))
}

class BottomView: UIView {

    var contentOffsetY: ContentOffsetYDelegate!
    var transactions: [TransactionModel] = []

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - init tableView on SubView
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(BottomTableViewCell.self, forCellReuseIdentifier: "TableCell")
        backgroundColor = .white

        addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - TableViewDelegate and TableViewDataSource

extension BottomView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? BottomTableViewCell else { return UITableViewCell() }
        //Тестовый вариант для прорверки
        cell.transaction = transactions[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetY.headerAnimation(contentOffsetY: scrollView.contentOffset.y) { (contentOffset) in
            scrollView.contentOffset.y = contentOffset
        }  // для анимации хедера
    }

}
