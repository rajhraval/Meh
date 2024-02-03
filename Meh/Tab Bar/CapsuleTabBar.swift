//
//  CapsuleTabBar.swift
//  Meh
//
//  Created by Raj Raval on 02/02/24.
//

import UIKit

protocol CapsuleTabDelegate: AnyObject {
    func didSelectTab(_ tag: Int)
}

final class CapsuleTabBar: UIView {

    weak var delegate: CapsuleTabDelegate?

    var selectedIndex: Int = 0
    var tabBarItems: [TabItem] = []

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewAndConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let safeArea = superview?.safeAreaInsets ?? safeAreaInsets
        return CGSize(width: size.width, height: safeArea.bottom)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.applyCapsuleShadowAndCorner()
    }

    private func setupViewAndConstraints() {
        addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.addSubview(buttonStackView)
        buttonStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24).isActive = true
    }

    func selectItem(_ index: Int) {
        selectedIndex = index
    }

    func setupTabBar(for items: [TabItem]) {
        tabBarItems = items
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        setupButtons(for: items).forEach(buttonStackView.addArrangedSubview)
    }

    private func setupButtons(for items: [TabItem]) -> [MehButton] {
        let buttons = items.map { item in
            let mehButton = MehButton(style: .icon)
            mehButton.image = item.image
            mehButton.tag = item.tag
            mehButton.font = .h3
            mehButton.foregroundColour = selectedIndex == item.tag ? item.selectedColor : item.color
            mehButton.addAction(UIAction { [weak self] _ in
                guard let self = self else { return }
                tabItemTapped(item)
            }, for: .touchUpInside)
            return mehButton
        }
        return buttons
    }

    private func tabItemTapped(_ item: TabItem) {
        delegate?.didSelectTab(item.tag)
        UISelectionFeedbackGenerator().selectionChanged()
        changeColor(for: item)
    }

    private func changeColor(for item: TabItem) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .allowAnimatedContent]) { [weak self] in
            guard let self = self else { return }
            buttonStackView.arrangedSubviews
                .compactMap { $0 as? MehButton }
                .forEach { button in
                    let selectedButton = button.tag == item.tag
                    button.foregroundColour = selectedButton ? item.selectedColor : item.color
                    if item.tag == 0 {
                        button.transform = selectedButton ? CGAffineTransform(scaleX: 1.4, y: 1.4) : .identity
                    } else if item.tag == 1 {
                        button.transform3D = selectedButton ? CATransform3DRotate(button.transform3D, .pi, 0, 1, 0) : CATransform3DIdentity
                    } else {
                        button.transform = selectedButton ? CGAffineTransform(rotationAngle: CGFloat.pi / 2) : .identity
                    }
                }
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .allowUserInteraction]) { [weak self] in
                guard let self = self else { return }
                buttonStackView.arrangedSubviews
                    .compactMap { $0 as? MehButton }
                    .forEach { button in
                        let selectedButton = button.tag == item.tag
                        button.foregroundColour = selectedButton ? item.selectedColor : item.color
                        button.transform = .identity
                    }
            }
        }
    }

}
