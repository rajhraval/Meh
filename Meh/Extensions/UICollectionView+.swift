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

    func registerCells(_ cellClasses: [UICollectionViewCell.Type]) {
        for cellClass in cellClasses {
            let identifier = String(describing: cellClass)
            self.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(identifier)")
        }
        return cell
    }

    func registerSupplementaryView(_ viewClasses: [UICollectionReusableView.Type], ofKind kind: String) {
        for viewClass in viewClasses {
            let identifier = String(describing: viewClass)
            self.register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, forIndexPath indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Error dequeuing supplementary view for identifier \(identifier)")
        }
        return view
    }
}
