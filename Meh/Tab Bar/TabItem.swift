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

    var title: String {
        return rawValue.capitalized
    }

    var image: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .settings:
            return UIImage(systemName: "gearshape.fill")!
        case .favorite:
            return UIImage(systemName: "heart.fill")!
        }
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
        return UITabBarItem(title: title, image: image, tag: tag)
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
