//
//  MehTextField.swift
//  Meh
//
//  Created by Raj Raval on 03/02/24.
//

import UIKit

final class MehTextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        font = .pSmall(isBold: true)
        backgroundColor = .secondarySystemBackground
        cornerRadius(10)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
