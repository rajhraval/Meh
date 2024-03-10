//
//  UsesAutoLayout.swift
//  Meh
//
//  Created by Raj Raval on 10/03/24.
//

/// Inspired by: https://www.fadel.io/blog/posts/30-tips-to-make-you-a-better-ios-developer/
/// From: https://github.com/bielikb/UseAutoLayout
import UIKit

@propertyWrapper
public struct UseAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            setAutoLayout()
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }

    func setAutoLayout() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
