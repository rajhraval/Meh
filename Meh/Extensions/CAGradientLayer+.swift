//
//  CAGradientLayer+.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

extension CAGradientLayer {

    static func createRandomGradientLayer(in frame: CGRect) -> Self {
        let randomGradient = GradientColor.colors.randomElement()!
        let layer = Self()
        layer.colors = [randomGradient.startColor.cgColor, randomGradient.endColor.cgColor]
        layer.startPoint = randomGradient.startPoint
        layer.endPoint = randomGradient.endPoint
        layer.frame = frame
        return layer
    }

}
