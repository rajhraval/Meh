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
        clipsToBounds = true
    }

    func applyCapsuleShadowAndCorner(color: UIColor = .black, opacity: Float = 0.1) {
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

}
