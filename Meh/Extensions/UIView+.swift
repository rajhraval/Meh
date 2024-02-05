//
//  UIView+.swift
//  Meh
//
//  Created by Raj Raval on 02/02/24.
//

import UIKit

extension UIView {

    func clipShapeCapsule() {
        layer.cornerRadius = bounds.height / 2.0
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }

    func cornerRadius(_ value: CGFloat = 20) {
        layer.cornerRadius = value
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }

    func applyCapsuleShadowAndCorner(color: UIColor = .label, opacity: Float = 0.1) {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func pinToLeadingAndTrailingEdgesWithConstant(_ constant: CGFloat = 0) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
        ])
    }

    func pinToSafeTopBottomLeadingTrailingEdgesWithConstant(_ constant: CGFloat = 0) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
        ])
    }

    func pinToTopBottomLeadingTrailingEdgesWithConstant(_ constant: CGFloat = 0) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
        ])
    }

    func pinToTopBottomLeadingTrailingEdgesWithConstants(
        topConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        leadingConstant: CGFloat = 0,
        trailingConstant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottomConstant),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailingConstant)
        ])
    }

    func pinToTopBottomLeadingTrailingEdgesWithConstants(
        verticalConstant: CGFloat = 0,
        horizontalConstant: CGFloat = 0
    ) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: verticalConstant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -verticalConstant),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: horizontalConstant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -horizontalConstant)
        ])
    }


    func centerHorizontallyInSuperview() {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }

    func centerVerticallyInSuperview() {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }

    func centerInSuperview() {
        centerHorizontallyInSuperview()
        centerVerticallyInSuperview()
    }

    static func createSpacerView() -> UIView {
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        let constraint = spacerView.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        constraint.priority = .defaultLow
        constraint.isActive = true
        return spacerView
    }

    func setWidthHeightConstraints(_ constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func imageFromView(_ view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)

        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }

        return image
    }

}
