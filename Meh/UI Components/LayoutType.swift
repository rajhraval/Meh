//
//  LayoutType.swift
//  Meh
//
//  Created by Raj Raval on 30/01/24.
//

import UIKit

enum LayoutType {
    case singleRow

    var layout: UICollectionViewCompositionalLayout {
        switch self {
        case .singleRow:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 24
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
    }
}
