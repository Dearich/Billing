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
    func showPopUpView()
}
protocol ShowBillingPopUP: class {
    func showPopUP(indexPath: IndexPath)
}
protocol IndexPathForLongGestureRecognizer: class {
    func indexPathForGestureRecognizer(_ indexPath: IndexPath) -> IndexPath
}

class HeaderView: UIView, HeaderDataSourceProtocol, ShowPopUpViewProtocol {
    
    var control: UIPageControl = UIPageControl(frame: .zero)
    

    weak var headerViewDelegate: HeaderViewProtocol?

    lazy var dataSource: HeaderDataSource = {
        let dataSource = HeaderDataSource()
        return dataSource
    }()

    let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()

    weak var headerViewDelegate: HeaderViewProtocol?
    weak var showBillingPopUp: ShowBillingPopUP?
    weak var indexPathForGestureRecognizer: IndexPathForLongGestureRecognizer?
    var billingArray: [Any] = []
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(centeredCollectionViewFlowLayout: self.centeredCollectionViewFlowLayout)
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
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.addConstraintsWithFormat(format: "V:|-[v0]-20-|", views: collectionView)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
        centeredCollectionViewFlowLayout.itemSize = CGSize(
          width: 190,
          height: self.bounds.height * 0.8
        )
        centeredCollectionViewFlowLayout.minimumLineSpacing = 15
//        centeredCollectionViewFlowLayout.sectionInset  = .init(top: 0, left: 10, bottom: 20, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(control)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addConstraintsWithFormat(format: "V:[v0(20)]-|", views: control)
        control.addConstraintsWithFormat(format: "H:|-[v0]-|", views: control)
        control.pageIndicatorTintColor = UIColor.systemGray
        control.currentPageIndicatorTintColor = .black
        control.currentPage = 0
        control.isEnabled = false

    }
    @objc func longTap(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:

            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            //TODO: Изолировать Ячейку
//            guard let index = indexPathForGestureRecognizer?.indexPathForGestureRecognizer(selectedIndexPath) else { return }
            showBillingPopUp?.showPopUP(indexPath: selectedIndexPath)
        default:
            return
        }
    }
    // MARK: - Padding and ScrollDirection in CV
    func animationAddView() {
        headerViewDelegate?.showPopUpView()
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
extension HeaderView {
    func shouldStartAnimation() {
        headerViewDelegate?.showPopUpView()
        
    }
    
}

// MARK: - Size for Cells
extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: collectionView.frame.height * 0.7)
    }
}
//TODO: Изолировать Ячейку
extension HeaderView: IndexPathForLongGestureRecognizer {
    func indexPathForGestureRecognizer(_ indexPath: IndexPath) -> IndexPath {
        billingArray.removeLast()
        return indexPath
    }
}
