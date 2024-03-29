//
//  UIColor+.swift
//  Meh
//
//  Created by Raj Raval on 01/02/24.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    static var randomColor: UIColor {
        let colors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPink, .systemPink, .systemPurple, .systemTeal, .systemMint, .systemIndigo]
        return colors.randomElement()!
    }

    var hex: String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "#000000" // Default to black if unable to get components
        }

        // Convert components to hex values
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)

        // Create the hex string
        let hexString = String(format: "#%02X%02X%02X", red, green, blue)

        return hexString
    }
}
