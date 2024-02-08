//
//  UIFont+.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

extension UIFont {
    
    private static func customFont(with name: FontName = .plusJakartaSans, weight: FontWeight, size: FontSize) -> UIFont {
        return UIFont(name: "\(name.name)\(weight.name)", size: size.rawValue)!
    }

    /// Extrabold, 56
    static var h0 = customFont(weight: .extraBold, size: .h0)
    /// Bold, 36
    static var h1 = customFont(weight: .bold, size: .h1)
    /// Extrabold, 34
    static var h2 = customFont(weight: .extraBold, size: .h2)
    /// Bold, 22
    static var h3 = customFont(weight: .bold, size: .h3)
    /// Extrabold, 20
    static var pLarge = customFont(weight: .extraBold, size: .pLarge)
    /// Bold, 18
    static var p = customFont(weight: .bold, size: .p)
    /// Bold, 16
    static func pSmall(isBold: Bool = false) -> UIFont { customFont(weight: isBold ? .bold : .semiBold, size: .pSmall) }
    /// Bold, 12
    static var pTiny = customFont(weight: .bold, size: .pSmall)
    /// Heavy, 18
    static var symbol = UIFont.systemFont(ofSize: 18, weight: .heavy)

}
