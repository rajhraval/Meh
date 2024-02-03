//
//  UIStackView+.swift
//  Meh
//
//  Created by Raj Raval on 03/02/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
