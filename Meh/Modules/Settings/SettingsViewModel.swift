//
//  SettingsViewModel.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import Foundation

enum Section: String, CaseIterable {
    case about
    case meta

    var title: String {
        switch self {
        case .about:
            return "About"
        case .meta:
            return ""
        }
    }
}

final class SettingsViewModel: ObservableObject {

    @Published var sections: [Section] = Section.allCases

}
