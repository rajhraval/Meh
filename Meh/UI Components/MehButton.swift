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
    case label
    case text

    case jumboText
    case jumboSymbol
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

    var size: UIButton.Configuration.Size = .large {
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
        var configuration: UIButton.Configuration
        switch style {
        case .symbol, .icon:
            configuration = style == .symbol ? .filled() : .plain()
            let fontConfig = UIImage.SymbolConfiguration(font: style == .symbol ? .h3 : .symbol)
            configuration.image = image.applyingSymbolConfiguration(fontConfig)
            configuration.baseForegroundColor = foregroundColour

            if style == .symbol {
                configuration.buttonSize = size
                configuration.cornerStyle = radius
                configuration.baseBackgroundColor = backgroundColour
            }
        case .text, .label:
            configuration = style == .text ? .filled() : .plain()

            configuration.baseForegroundColor = foregroundColour
            configuration.title = title
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(name: self.font.fontName, size: self.font.pointSize)!
                return outgoing
            }

            if style == .text {
                configuration.buttonSize = size
                configuration.cornerStyle = radius
                configuration.baseBackgroundColor = backgroundColour
            }
        case .jumboText, .jumboSymbol:
            configuration = .filled()
            if style == .jumboText {
                configuration.title = title
                configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = UIFont(name: self.font.fontName, size: self.font.pointSize)!
                    return outgoing
                }
            }
            if style == .jumboSymbol {
                let fontConfig = UIImage.SymbolConfiguration(font: .h3)
                configuration.image = image.applyingSymbolConfiguration(fontConfig)
            }
            configuration.baseForegroundColor = foregroundColour
            configuration.baseBackgroundColor = style == .jumboSymbol ? backgroundColour : backgroundColour.withAlphaComponent(0.1)
            configuration.cornerStyle = .capsule
            configuration.buttonSize = .large
        }
        self.configuration = configuration
    }

}
