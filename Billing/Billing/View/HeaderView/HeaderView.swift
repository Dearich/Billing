//
//  HeaderView.swift
//  Billing
//
//  Created by Temirlan Dzodziev on 27.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.5647058824, blue: 0.4784313725, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        flowLayout()
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
        
    }
    
    //MARK:- Padding and ScrollDirection in CV
    fileprivate func flowLayout(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let padding : CGFloat = 25
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            layout.minimumLineSpacing = 25
            layout.scrollDirection = .horizontal
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- DataSource and Delegate for CV

extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeaderCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4156862745, blue: 0.5843137255, alpha: 1)
        cell.layer.cornerRadius = 10
        let shadowSize: CGFloat = 7
        let contactRect = CGRect(x: -shadowSize, y: cell.bounds.height - (shadowSize * 0.4), width: cell.bounds.width + shadowSize * 2, height: shadowSize)
        cell.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 1
        return cell
    }
}

//MARK:- Size for Cells
extension HeaderView: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 140)
    }
}


