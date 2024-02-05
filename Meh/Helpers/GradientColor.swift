//
//  GradientColor.swift
//  Meh
//
//  Created by Raj Raval on 01/02/24.
//

import UIKit

struct GradientColor {
    let startColor: UIColor
    let endColor: UIColor
    let angle: CGFloat

    var startPoint: CGPoint {
        pointForAngle(angle)
    }

    var endPoint: CGPoint {
        pointForAngle(angle + 180)
    }

    private func pointForAngle(_ angle: CGFloat) -> CGPoint {
        let angleInRadians = angle * .pi / 180.0
        return CGPoint(x: 0.5 + 0.5 * cos(angleInRadians), y: 0.5 - 0.5 * sin(angleInRadians))
    }
}

extension GradientColor {
    static let colors = [
        GradientColor(startColor: UIColor(hex: "#A531DC"), endColor: UIColor(hex: "#4300B1"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#FF896D"), endColor: UIColor(hex: "#D02020"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#3793FF"), endColor: UIColor(hex: "#0017E4"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#FFD439"), endColor: UIColor(hex: "#FF7A00"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#00B960"), endColor: UIColor(hex: "#00552C"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#24CFC5"), endColor: UIColor(hex: "#001C63"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#5D85A6"), endColor: UIColor(hex: "#0E2C5E"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#FFC328"), endColor: UIColor(hex: "#E20000"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#61C695"), endColor: UIColor(hex: "#133114"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#FADD76"), endColor: UIColor(hex: "#9F3311"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#4643DF"), endColor: UIColor(hex: "#0B0A47"), angle: 220.55),
        GradientColor(startColor: UIColor(hex: "#5EE2FF"), endColor: UIColor(hex: "#00576A"), angle: 220.55)
    ]
}
