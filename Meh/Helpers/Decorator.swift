//
//  Decorator.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

final class Decorator {

    init() {}

    func decorate() {
        setupCustomNavigationBarAppearance()
        setupCustomTabBarAppearance()
    }

    private func setupCustomNavigationBarAppearance() {
        let mehAppearance = UINavigationBarAppearance()
        mehAppearance.configureWithTransparentBackground()

        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.h2,
            .foregroundColor: UIColor.label
        ]

        mehAppearance.largeTitleTextAttributes = attributes
        //mehAppearance.titleTextAttributes = attributes

        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label, .font: UIFont.pSmall]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.tertiaryLabel, .font: UIFont.pSmall]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.systemGray, .font: UIFont.pSmall]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.label, .font: UIFont.pSmall]

        mehAppearance.buttonAppearance = barButtonItemAppearance
        mehAppearance.doneButtonAppearance = barButtonItemAppearance
        mehAppearance.backButtonAppearance = barButtonItemAppearance

        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .label
        appearance.prefersLargeTitles = true
        appearance.scrollEdgeAppearance = mehAppearance
        appearance.compactAppearance = mehAppearance
        appearance.standardAppearance = mehAppearance
        appearance.compactScrollEdgeAppearance = mehAppearance
    }

    private func setupCustomTabBarAppearance() {
        let mehAppearance = UITabBarAppearance()
        mehAppearance.configureWithTransparentBackground()
        mehAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)

        let appearance = UITabBar.appearance()
        appearance.tintColor = .label
        appearance.standardAppearance = mehAppearance
        appearance.scrollEdgeAppearance = mehAppearance
    }

}
