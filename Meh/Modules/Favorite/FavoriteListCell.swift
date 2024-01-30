//
//  FavoriteListCell.swift
//  Meh
//
//  Created by Raj Raval on 30/01/24.
//

import UIKit

class FavoriteListCell: UICollectionViewCell {

    var deleteAction: (() -> Void)?

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        return view
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    private var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
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
        titleLabel.text = nil
    }

    private func setup() {
        setupView()
        setupLabel()
        setupDeleteButton()
    }

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupLabel() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(deleteButton)
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }

    private func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }

    func configureCell(for item: MehItem) {
        titleLabel.text = item.name
    }

    @objc
    func deleteItem() {
        deleteAction?()
    }


}
