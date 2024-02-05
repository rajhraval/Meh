//
//  SettingsListCell.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit

class SettingsListCell: UICollectionViewCell {

    static let reuseIdentifier = "SettingsListCell"

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 18
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()

    private var imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        return view
    }()

    private var iconImageView: UIImageView = {
        let image = UIImage(systemName: "person.fill")!
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pSmall
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private var disclosure: UIImageView = {
        let image = UIImage(systemName: "chevron.right")!.withConfiguration(UIImage.SymbolConfiguration(font: .pSmall))
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGray
        return imageView
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

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.cornerRadius()
        imageContainerView.cornerRadius(10)
    }

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstants()
        containerView.addSubview(primaryStackView)
        primaryStackView.pinToLeadingAndTrailingEdgesWithConstant(16)
        primaryStackView.centerVerticallyInSuperview()
        primaryStackView.addArrangedSubviews(imageContainerView, titleLabel, UIView.createSpacerView(), disclosure)
        imageContainerView.setWidthHeightConstraints(40)
        setupImageContainerView()
    }

    private func setupImageContainerView() {
        imageContainerView.addSubview(iconImageView)
        iconImageView.pinToTopBottomLeadingTrailingEdgesWithConstant(8)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    func configureCell(with item: AboutItem) {
        imageContainerView.backgroundColor = item.color
        titleLabel.text = item.title
        iconImageView.image = UIImage(systemName: item.image)
        iconImageView.tintColor = .white
    }


}
