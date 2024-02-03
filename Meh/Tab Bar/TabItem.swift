//
//  TabItem.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import UIKit

enum TabItem: String, CaseIterable {
    case home
    case settings
    case favorite

    var title: String? {
        nil
    }

    var image: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "sparkles.rectangle.stack.fill")!
        case .settings:
            return UIImage(systemName: "gearshape.fill")!
        case .favorite:
            return UIImage(systemName: "heart.fill")!
        }
    }

    var selectedColor: UIColor {
        switch self {
        case .home:
            return .systemOrange
        case .settings:
            return .systemBlue
        case .favorite:
            return .systemPink
        }
    }

    var color: UIColor {
        return .label.withAlphaComponent(0.1)
    }

    var tag: Int {
        switch self {
        case .home:
            1
        case .settings:
            2
        case .favorite:
            0
        }
    }

    var tabBarItem: UITabBarItem {
        let congfiguration = UIImage.SymbolConfiguration(font: .p)
        let adjustedImage = image.withConfiguration(congfiguration).withBaselineOffset(fromBottom: 14)
        let item = UITabBarItem(title: title, image: adjustedImage, tag: tag)
        return item
    }

    var viewController: UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController()
            vc.tabBarItem = tabBarItem
            let navigationController = UINavigationController(rootViewController: vc)
            return navigationController
        case .settings:
            let vc = SettingsViewController()
            vc.tabBarItem = tabBarItem
            let navigationController = UINavigationController(rootViewController: vc)
            return navigationController
        case .favorite:
            let vc = FavoriteViewController()
            vc.tabBarItem = tabBarItem
            let navigationController = UINavigationController(rootViewController: vc)
            return navigationController
        }
    }

}
