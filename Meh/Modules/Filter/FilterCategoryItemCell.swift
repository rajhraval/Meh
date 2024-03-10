//
//  FilterCategoryItemCell.swift
//  Meh
//
//  Created by Raj Raval on 10/03/24.
//

import UIKit

class FilterCategoryItemCell: UICollectionViewCell {


    var didSelectCategory: ((String) -> Void)?

    @UseAutoLayout
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()

    @UseAutoLayout
    private var categoryButton: MehButton = {
        let button = MehButton(style: .chip)
        button.title = "Button"
        button.chipColor = .systemBlue
        return button
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
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        containerView.addSubview(categoryButton)
        categoryButton.pinToTopBottomLeadingTrailingEdgesWithConstants(topConstant: 0, bottomConstant: 4, trailingConstant: 6)
        categoryButton.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
    }

    func configure(for categoryItem: CategoryItem) {
        categoryButton.title = categoryItem.name
        categoryButton.chipColor = categoryItem.color
    }

    @objc func selectCategory(_ sender: MehButton) {
        categoryButton.isSelected.toggle()
        didSelectCategory?(sender.title)
    }


}
