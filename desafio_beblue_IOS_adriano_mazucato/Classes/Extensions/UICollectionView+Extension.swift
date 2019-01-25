//
//  UICollectionView+Extension.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var cellIdentifier: String { get }
}

extension Reusable where Self: UICollectionViewCell {
    public static var cellIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: cellClass.cellIdentifier)
    }
//
//    func cell<T: Reusable>(forClass cellClass: T.Type, indexPath:IndexPath)-> T? {
//        return dequeueReusableCell(withReuseIdentifier: cellClass.cellIdentifier, for: indexPath)  as? T
//    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type = T.self, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.cellIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.cellIdentifier) matching type \(cellType.self)")
        }
        
        return cell
    }
}

extension UICollectionViewCell: Reusable { }
