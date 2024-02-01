//
//  UICollectionView+.swift
//  Meh
//
//  Created by Raj Raval on 30/01/24.
//

import UIKit

extension UICollectionView {
    convenience init(frame: CGRect, layout: LayoutType) {
        self.init(frame: frame, collectionViewLayout: layout.layout)
    }
}
