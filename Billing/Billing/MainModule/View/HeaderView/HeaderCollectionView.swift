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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        dataSource.headerDataSourceDelegate = self
        
        addSubview(collectionView)
        addConstraints(20, collectionView)
        centeredCollectionViewFlowLayout.minimumLineSpacing = 15
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        centeredCollectionViewFlowLayout.scrollDirection = .horizontal
        
        addSubview(control)
        control.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(20, control)
        control.pageIndicatorTintColor = UIColor.systemGray
        control.currentPageIndicatorTintColor = .black
        control.currentPage = 0
        control.isEnabled = false
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
