//
//  MehHeaderSection.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit

class MehHeaderSection: UICollectionReusableView {

    static let reuseIdentifier = "MehHeaderSection"

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .pSmall
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pTiny
        label.textAlignment = .left
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        subtitleLabel.text = nil
    }

    private func setup() {
        setupView()
    }

    private func setupView() {
        addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstants()
        containerView.addSubview(primaryStackView)
        primaryStackView.pinToTopBottomLeadingTrailingEdgesWithConstants(verticalConstant: 8, horizontalConstant: 16)
        primaryStackView.addArrangedSubviews(label, subtitleLabel)
    }

    func configureHeader(for section: Section) {
        subtitleLabel.isHidden = true
        if section == .about {
            label.text = section.title.uppercased()
        }
    }

    func configureFilterHeader(for section: FilterSection) {
        label.text = section.title
        label.textColor = .label
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.text = section.subtitle
    }

}
