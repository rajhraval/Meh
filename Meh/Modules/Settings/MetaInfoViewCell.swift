//
//  MetaInfoViewCell.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit

class MetaInfoViewCell: UICollectionViewCell {

    static let reuseIdentifier = "MetaInfoViewCell"

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .pSmall(isBold: true)
        label.textAlignment = .center
        label.textColor = .label
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
    }

    private func setup() {
        setupView()
    }

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstants()
        containerView.addSubview(label)
        label.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        label.pinToLeadingAndTrailingEdgesWithConstant(16)
        label.text = "Made with ❤️ in 🇮🇳"
    }

}
