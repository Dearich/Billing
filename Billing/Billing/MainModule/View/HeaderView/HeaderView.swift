//
//  HeaderView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

protocol HeaderViewProtocol: class {
    func showPopUpView()
}

class HeaderView: UIView {

    weak var headerViewDelegate: HeaderViewProtocol?

    lazy var dataSource: HeaderDataSource = {
        let dataSource = HeaderDataSource()
        return dataSource
    }()

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.dataSource = self.dataSource
        view.delegate = self.dataSource
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()

    var longPressGesture: UILongPressGestureRecognizer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        dataSource.headerDataSourceDelegate = self
        flowLayout()
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.addConstraintsWithFormat(format: "V:|-[v0]-|", views: collectionView)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc func longTap(_ gesture: UIGestureRecognizer) {

        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
            else { return }

        case .ended:

            self.collectionView.reloadData()
        default:
            return
        }
    }

    // MARK: - Padding and ScrollDirection in CV
    fileprivate func flowLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let padding: CGFloat = 10
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            layout.minimumLineSpacing = 25
            layout.scrollDirection = .horizontal
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView:HeaderDataSourceProtocol {
    func shouldStartAnimation() {
        headerViewDelegate?.showPopUpView()
    }
}
