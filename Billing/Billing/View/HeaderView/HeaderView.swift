//
//  HeaderView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var billingArray: Billings!

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        flowLayout()
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.addConstraintsWithFormat(format: "V:|-[v0]-|", views: collectionView)
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
        cell.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4156862745, blue: 0.5843137255, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.balanceLabel.text = billingArray![indexPath.row].balance
        cell.ownerLabel.text = billingArray![indexPath.row].owner
        //shadow
        let shadowSize: CGFloat = 7
        let contactRect = CGRect(x: -shadowSize, y: cell.bounds.height - (shadowSize * 0.4), width: cell.bounds.width + shadowSize * 2, height: shadowSize)
        cell.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(collectionCelllongTapped)))
    }
    
    @objc fileprivate func collectionCelllongTapped(){
        
    }
}

//MARK:- Size for Cells
extension HeaderView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: collectionView.frame.height * 0.7)
    }
}
