//
//  SettingsHeaderSection.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit

class SettingsHeaderSection: UICollectionReusableView {

    static let reuseIdentifier = "SettingsHeaderSection"

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupView()
    }

    private func setupView() {
        addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstants()
        containerView.addSubview(label)
        label.centerVerticallyInSuperview()
        label.pinToLeadingAndTrailingEdgesWithConstant(24)
    }

    func configureHeader(for section: Section) {
        if section == .about {
            label.text = section.title.uppercased()
        }
    }

}
