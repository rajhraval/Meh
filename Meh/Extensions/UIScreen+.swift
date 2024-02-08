//
//  UIScreen+.swift
//  Meh
//
//  Created by Raj Raval on 07/02/24.
//

import UIKit

extension UIScreen {
    static var current: UIScreen {
        UIWindow.current?.screen ?? main
    }
}
