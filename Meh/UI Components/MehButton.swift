//
//  MehButton.swift
//  Meh
//
//  Created by Raj Raval on 31/01/24.
//

import UIKit

enum MehButtonStyle {
    case icon
    case symbol
    case text
}

final class MehButton: UIButton {

    var title: String = "Button" {
        didSet {
            setupButton()
        }
    }

    var style: MehButtonStyle = .text {
        didSet {
            setupButton()
        }
    }

    var image: UIImage = UIImage(systemName: "heart.fill")! {
        didSet {
            setupButton()
        }
    }

    var size: UIButton.Configuration.Size = .medium {
        didSet {
            setupButton()
        }
    }

    var radius: UIButton.Configuration.CornerStyle = .large {
        didSet {
            setupButton()
        }
    }

    var foregroundColour: UIColor = .white {
        didSet {
            setupButton()
        }
    }

    var backgroundColour: UIColor = .systemOrange {
        didSet {
            setupButton()
        }
    }

    var font: UIFont = .h3 {
        didSet {
            setupButton()
        }
    }

    init(style: MehButtonStyle) {
        super.init(frame: .zero)
        self.style = style
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        var configuration: UIButton.Configuration = style != .icon ? .filled() : .plain()
        configuration.buttonSize = size
        configuration.baseForegroundColor = foregroundColour
        if style == .text  {
            configuration.title = title
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(name: self.font.fontName, size: self.font.pointSize)!
                return outgoing
            }
        }
        if style != .icon {
            configuration.cornerStyle = radius
            configuration.baseBackgroundColor = backgroundColour
        }
        if style != .text {
            let fontConfig = UIImage.SymbolConfiguration(font: style == .icon ? .symbol : .h3)
            configuration.image = image.applyingSymbolConfiguration(fontConfig)
        }
        self.configuration = configuration
    }

}
