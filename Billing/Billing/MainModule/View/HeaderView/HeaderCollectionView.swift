//
//  HeaderView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import CenteredCollectionView

protocol HeaderViewProtocol: class {
    func showPopUpAddView()
    func showPopUpDeleteView(billing: BillingModel?)
    var deleteView: DeleteViewController? { get }
}

class HeaderCollectionView: UIView, HeaderDataSourceProtocol {
    var deleteView: DeleteViewController?
    

    var control: UIPageControl = UIPageControl(frame: .zero)
    weak var headerViewDelegate: HeaderViewProtocol?

    lazy var dataSource: HeaderDataSource = {
        let dataSource = HeaderDataSource()
        return dataSource
    }()

    let centeredCollectionViewFlowLayout = UICollectionViewFlowLayout()

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: centeredCollectionViewFlowLayout)
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
        addSubview(collectionView)
        collectionView.addConstraintsWithFormat(format: "V:|-[v0]-20-|", views: collectionView)
        collectionView.addConstraintsWithFormat(format: "H:|-[v0]-|", views: collectionView)
        centeredCollectionViewFlowLayout.minimumLineSpacing = 15
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        centeredCollectionViewFlowLayout.scrollDirection = .horizontal
        addSubview(control)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addConstraintsWithFormat(format: "V:[v0(20)]-|", views: control)
        control.addConstraintsWithFormat(format: "H:|-[v0]-|", views: control)
        control.pageIndicatorTintColor = UIColor.systemGray
        control.currentPageIndicatorTintColor = .black
        control.currentPage = 0
        control.isEnabled = false

    }
    
    // MARK: - Padding and ScrollDirection in CV

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCollectionView {
    func shouldStartAnimationAddView() {
        headerViewDelegate?.showPopUpAddView()
    }
    
    func shouldStartAnimationDeleteView(billing: BillingModel?) {
        headerViewDelegate?.showPopUpDeleteView(billing: billing)
        deleteView = headerViewDelegate?.deleteView
    }
}
