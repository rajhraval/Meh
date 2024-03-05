//
//  FilterViewModel.swift
//  Meh
//
//  Created by Raj Raval on 06/02/24.
//

import Foundation
import UIKit.UICollectionViewCompositionalLayout


final class FilterViewModel: ObservableObject {
    
    @Published var sections: [FilterSection] = FilterSection.allCases

    

}

extension FilterViewModel {
    enum FilterSection: Int, CaseIterable {
        case category
        case participants
        case price
        case accessibility

        var title: String {
            switch self {
            case .category:
                return "Category"
            case .price:
                return "Cost"
            case .participants:
                return "People"
            case .accessibility:
                return "Ease of Doing it"
            }
        }

        var subtitle: String {
            switch self {
            case .category:
                return "Gotta try them all!"
            case .price:
                return "Not real, but an estimate."
            case .participants:
                return "How many people needed?"
            case .accessibility:
                return "How easy it is?"
            }
        }

        var numberOfItems: Int {
            switch self {
            case .category:
                return CategoryItem.items.count
            default:
                return 1
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
                return  .absolute(44)
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
}
