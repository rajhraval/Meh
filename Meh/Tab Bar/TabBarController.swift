//
//  TabBarController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let controllers = [
            TabItem.favorite.viewController,
            TabItem.home.viewController,
            TabItem.settings.viewController
        ]
        viewControllers = controllers
        selectedIndex = TabItem.home.tag
    }

}
