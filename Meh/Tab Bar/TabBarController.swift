//
//  TabBarController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import UIKit

final class TabBarController: UITabBarController {

    private var capsuleTabBar: CapsuleTabBar = {
        let tabBar = CapsuleTabBar()
        return tabBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tabBarSize = capsuleTabBar.sizeThatFits(view.bounds.size)
        let safeArea = view.safeAreaInsets
        let y = view.bounds.height - safeArea.bottom
        capsuleTabBar.frame = CGRect(origin: CGPoint(x: 0, y: y), size: tabBarSize)
        additionalSafeAreaInsets.bottom = 64
    }

    private func setup() {
        view.addSubview(capsuleTabBar)

        let tabBarItems: [TabItem] = [.favorite, .home, .settings]
        let controllers = [
            TabItem.favorite.viewController,
            TabItem.home.viewController,
            TabItem.settings.viewController
        ]

        let homeIndex = TabItem.home.tag

        capsuleTabBar.delegate = self
        capsuleTabBar.selectedIndex = homeIndex
        capsuleTabBar.setupTabBar(for: tabBarItems)

        hideTabBar()
        
        viewControllers = controllers
        selectedIndex = homeIndex
        delegate = self
    }

    private func hideTabBar() {
        tabBar.layer.zPosition = -1
        tabBar.isHidden = true
    }

}

extension TabBarController: CapsuleTabDelegate, UITabBarControllerDelegate {

    func didSelectTab(_ tag: Int) {
        selectedIndex = tag
        capsuleTabBar.selectItem(tag)
    }

}
