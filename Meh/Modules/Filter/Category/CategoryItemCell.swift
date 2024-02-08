//
//  CategoryItemCell.swift
//  Meh
//
//  Created by Raj Raval on 06/02/24.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {

    static let reuseIdentifier = "CategoryItemCell"

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .pSmall(isBold: true)
        label.text = "music"
        label.textColor = .white
        return label
    }()

    private var iconImageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(font: .h3)
        let image = UIImage(systemName: "person.fill")!.withConfiguration(configuration)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
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
        containerView.cornerRadius(15)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconImageView.image = nil
    }

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        containerView.addSubview(titleLabel)
        containerView.addSubview(iconImageView)
        iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        iconImageView.centerVerticallyInSuperview()
        titleLabel.centerVerticallyInSuperview()
        iconImageView.setWidthHeightConstraints(24)
    }

    func configureCell(for item: CategoryItem) {
        titleLabel.text = item.name
        iconImageView.image = UIImage(systemName: item.image)!
        containerView.backgroundColor = item.color
    }


}
