//
//  FavoriteListCell.swift
//  Meh
//
//  Created by Raj Raval on 30/01/24.
//

import UIKit

class FavoriteListCell: UICollectionViewCell {

    static let reuseIdentifier = "FavoriteListCell"

    var deleteAction: (() -> Void)?
    var shareAction: (() -> Void)?

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemOrange
        return view
    }()

    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private var participantsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private var participantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🙋‍♂️"
        label.font = .p
        return label
    }()

    private var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "💸"
        label.font = .p
        return label
    }()

    private var infoCTAStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private var activityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .pLarge
        label.textColor = .white
        return label
    }()

    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .pTiny
        label.textColor = .white.withAlphaComponent(0.6)
        return label
    }()

    private var linkButton: MehButton = {
        let button = MehButton(style: .icon)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "link")!
        return button
    }()

    private var optionsButton: MehButton = {
        let button = MehButton(style: .icon)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "ellipsis.circle.fill")!
        return button
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
        activityLabel.text = nil
        categoryLabel.text = nil
        containerView.backgroundColor = nil
    }

    private func setup() {
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.cornerRadius()
        [priceView, participantsView].forEach { $0.cornerRadius(8) }
    }

    private func setupView() {
        setupContainerView()
    }

    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        setupStackView()
    }

    private func setupStackView() {
        containerView.addSubview(primaryStackView)
        primaryStackView.pinToTopBottomLeadingTrailingEdgesWithConstant(22)
        primaryStackView.addArrangedSubviews(labelsStackView, infoCTAStackView)
        labelsStackView.addArrangedSubviews(categoryLabel, activityLabel)
        let spacer = UIView.createSpacerView()
        infoCTAStackView.addArrangedSubviews(participantsView, priceView, spacer, linkButton, optionsButton)
        setupInfoStackConstraints()
    }

    private func setupInfoStackConstraints() {
        participantsView.addSubview(participantLabel)
        participantLabel.pinToTopBottomLeadingTrailingEdgesWithConstants(verticalConstant: 5, horizontalConstant: 10)


        priceView.addSubview(priceLabel)
        priceLabel.pinToTopBottomLeadingTrailingEdgesWithConstants(verticalConstant: 5, horizontalConstant: 10)

        linkButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        optionsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        setupOptionButton()
    }

    private func setupOptionButton() {
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: .destructive) { [weak self] _ in
            guard let self = self else { return }
            delete()
        }
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
            guard let self = self else { return }
            share()
        }
        optionsButton.showsMenuAsPrimaryAction = true
        optionsButton.menu = UIMenu(children: [deleteAction, shareAction])
    }

    func configureCell(for item: MehItem) {
        containerView.backgroundColor = UIColor(hex: item.color)
        activityLabel.text = item.name
        categoryLabel.text = item.type
        priceLabel.text = item.money
        participantLabel.text = item.emojis
        if item.link.isEmpty {
            linkButton.isHidden = true
        }
    }

    private func delete() {
        deleteAction?()
    }

    private func share() {
        shareAction?()
    }

}
