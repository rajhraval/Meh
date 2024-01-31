//
//  FontHelper.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

enum FontName: String {
    case plusJakartaSans

    var name: String {
        rawValue.capitalized
    }
}

enum FontWeight: String {
    case extraLight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case extraBold

    var name: String {
        "-" + rawValue.capitalized
    }
}

enum FontSize: CGFloat {
    case h0 = 56
    case h1 = 36
    case h2 = 34
    case h3 = 22
    case pLarge = 20
    case p = 18
    case pSmall = 16
    case pTiny = 12
}
