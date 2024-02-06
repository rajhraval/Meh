//
//  FilterViewModel.swift
//  Meh
//
//  Created by Raj Raval on 06/02/24.
//

import Foundation

enum FilterSection: String, CaseIterable {
    case category
    case price
    case participants
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
}

final class FilterViewModel: ObservableObject {
    
    @Published var sections: [FilterSection] = FilterSection.allCases

}
