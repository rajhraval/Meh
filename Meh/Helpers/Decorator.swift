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
    }

    private func setupCustomNavigationBarAppearance() {
        let mehAppearance = UINavigationBarAppearance()
        mehAppearance.configureWithTransparentBackground()

        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.h2,
            .foregroundColor: UIColor.label
        ]

        mehAppearance.largeTitleTextAttributes = attributes
        mehAppearance.titleTextAttributes = attributes

        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.tertiaryLabel]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.systemGray]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.label]

        mehAppearance.buttonAppearance = barButtonItemAppearance
        mehAppearance.doneButtonAppearance = barButtonItemAppearance
        mehAppearance.backButtonAppearance = barButtonItemAppearance

        let appearance = UINavigationBar.appearance()
        appearance.prefersLargeTitles = true
        appearance.scrollEdgeAppearance = mehAppearance
        appearance.compactAppearance = mehAppearance
        appearance.standardAppearance = mehAppearance
        appearance.compactScrollEdgeAppearance = mehAppearance
    }

}
