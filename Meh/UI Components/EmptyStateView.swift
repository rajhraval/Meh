//
//  EmptyStateView.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit

final class EmptyStateView: UIView {

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pSmall(isBold: true)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    var title: String? {
        didSet {
            setup()
        }
    }

    var subtitle: String? {
        didSet {
            setup()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupStackViewConstraints()
    }

    private func setupStackViewConstraints() {
        addSubview(stackView)
        stackView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        if let title, let subtitle = subtitle {
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(subtitleLabel)
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
    }

}
