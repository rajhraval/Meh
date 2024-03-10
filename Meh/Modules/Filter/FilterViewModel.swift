//
//  FilterViewModel.swift
//  Meh
//
//  Created by Raj Raval on 10/03/24.
//

import Foundation
import UIKit.UICollectionViewCompositionalLayout

enum FilterSection: Int, CaseIterable, HeaderSection {
    case category
    case participants
    case price
    case accessibility

    var title: String {
        switch self {
        case .category:
            return "Category"
        case .participants:
            return "Number of Participants"
        case .price:
            return "Price Range"
        case .accessibility:
            return "Ease of Doing"
        }
    }

    var numberOfItems: Int {
        switch self {
        case .category:
            return CategoryItem.items.count
        default:
            return 2
        }
    }

    var itemWidth: NSCollectionLayoutDimension {
        switch self {
        case .category:
            return .estimated(100)
        default:
            return .fractionalWidth(1)
        }
    }

    var itemHeight: NSCollectionLayoutDimension {
        switch self {
        case .category:
            return .absolute(44)
        default:
            return .estimated(100)
        }
    }

    var groupWidth: NSCollectionLayoutDimension {
        switch self {
        default:
            return .fractionalWidth(1)
        }
    }

    var groupHeight: NSCollectionLayoutDimension {
        switch self {
        default:
            return .estimated(44)
        }
    }

}

final class FilterViewModel: ObservableObject {

    @Published var sections: [FilterSection] = FilterSection.allCases

}
