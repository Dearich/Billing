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

class HeaderView: UIView, ShowPopUpViewProtocol {

    var billingArray: [Any]!
    weak var headerViewDelegate: HeaderViewProtocol?

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.dataSource = self
        view.delegate = self
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
        flowLayout()
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.addConstraintsWithFormat(format: "V:|-[v0]-|", views: collectionView)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longTap(_ gesture: UIGestureRecognizer){
        
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
        
        case .ended:
            
            self.collectionView.reloadData()
        default:
            return
        }
    }
    
    func animationAddView() {
          headerViewDelegate?.showPopUpView()
    }

    //MARK:- Padding and ScrollDirection in CV
    fileprivate func flowLayout(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let padding : CGFloat = 10
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding , right: padding)
            layout.minimumLineSpacing = 25
            layout.scrollDirection = .horizontal
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- CollectionViewDataSource and CollectionViewDelegate

extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard billingArray != nil else {return 0}
        return billingArray!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard billingArray != nil else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeaderCollectionViewCell
        cell.billing = billingArray![indexPath.row]
        cell.showPopUpViewDelegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}

//MARK:- Size for Cells
extension HeaderView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: collectionView.frame.height * 0.7)
    }
}
