//
//  MehNavigationView.swift
//  Meh
//
//  Created by Raj Raval on 06/03/24.
//

import UIKit

protocol MehNavigationSearchDelegate: AnyObject {
    func sortTapped()
    func filterTapped()
    func didSearch(for textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

protocol MehNavigationActionDelegate: AnyObject {
    func leftButtonTapped()
    func rightButtonTapped()
}

final class MehNavigationView: UIView {

    weak var actionDelegate: MehNavigationActionDelegate?
    weak var searchDelegate: MehNavigationSearchDelegate?

    var title: String = "Title" {
        didSet {
            setup()
        }
    }

    var subtitle: String = "Subtitle" {
        didSet {
            setup()
        }
    }

    var includesSearchBar: Bool = false {
        didSet {
            setup()
        }
    }

    var includesFilter: Bool = true {
        didSet {
            setup()
        }
    }

    var includesSort: Bool = true {
        didSet {
            setup()
        }
    }

    var includesBackButton: Bool = false {
        didSet {
            setupBackButton()
            setup()
        }
    }

    var leftBarButton: MehButton? = nil {
        didSet {
            setup()
        }
    }

    var rightBarButton: MehButton? = nil {
        didSet {
            setup()
        }
    }

    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private var navigationActionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private var backButton: MehButton = {
        let button = MehButton(style: .icon)
        button.foregroundColour = .black
        button.image = UIImage(systemName: "chevron.left")!
        return button
    }()

    private var navigationTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private var navigationTitle: UILabel = {
        let label = UILabel()
        label.font = .h2
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    private var navigationSubtitle: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = .secondaryLabel
        label.minimumScaleFactor = 0.7
        label.textAlignment = .left
        return label
    }()

    private var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private var searchField: MehTextField = {
        let textField = MehTextField()
        textField.placeholder = "Search"
        return textField
    }()

    private var filterButton: MehButton = {
        let button = MehButton(style: .symbol)
        button.image = UIImage(systemName: "slider.horizontal.3")!
        button.backgroundColour = .systemIndigo
        return button
    }()

    private var sortButton: MehButton = {
        let button = MehButton(style: .symbol)
        button.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")!
        return button
    }()

    private var navigationButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(primaryStackView)
        primaryStackView.pinToSafeTopBottomLeadingTrailingEdgesWithConstant(24)

        // Scenario 1: Only Titles
        if rightBarButton == nil, leftBarButton == nil, !includesSearchBar, !includesBackButton {
            primaryStackView.addArrangedSubview(navigationTitleStackView)
            navigationTitleStackView.addArrangedSubviews(navigationTitle, navigationSubtitle)
        }

        // Scenario 2: Titles with Right Button
        if let rightBarButton, leftBarButton == nil, !includesSearchBar, !includesBackButton {
            primaryStackView.addArrangedSubview(navigationActionStackView)
            navigationActionStackView.addArrangedSubview(navigationTitleStackView)
            navigationTitleStackView.addArrangedSubviews(navigationTitle, navigationSubtitle)
            navigationActionStackView.addArrangedSubview(rightBarButton)
        }

        // Scenario 3: Titles with Back Button and Right Button
        if let leftBarButton, let rightBarButton, includesBackButton {
            primaryStackView.addArrangedSubview(navigationButtonStackView)
            navigationButtonStackView.addArrangedSubviews(leftBarButton, rightBarButton)
            primaryStackView.addArrangedSubview(navigationTitleStackView)
            navigationTitleStackView.addArrangedSubviews(navigationTitle, navigationSubtitle)
        }

        // Scenario 4: Titles with Back Button and Right Button and Search
        if let leftBarButton, let rightBarButton, includesBackButton, includesSearchBar {
            primaryStackView.addArrangedSubview(navigationButtonStackView)
            navigationButtonStackView.addArrangedSubviews(leftBarButton, UIView.createSpacerView(), rightBarButton)
            primaryStackView.addArrangedSubview(navigationTitleStackView)
            navigationTitleStackView.addArrangedSubviews(navigationTitle, navigationSubtitle)
            primaryStackView.addArrangedSubview(searchStackView)
            searchStackView.addArrangedSubview(searchField)
            if includesSort {
                searchStackView.addArrangedSubview(sortButton)
                setupSortButton()
            }
            if includesFilter {
                searchStackView.addArrangedSubview(filterButton)
                setupFilterButton()
            }
        }

        if rightBarButton == nil, leftBarButton == nil, includesSearchBar {
            primaryStackView.addArrangedSubview(navigationTitleStackView)
            navigationTitleStackView.addArrangedSubviews(navigationTitle, navigationSubtitle)
            primaryStackView.addArrangedSubview(searchStackView)
            searchStackView.addArrangedSubview(searchField)
            if includesSort {
                searchStackView.addArrangedSubview(sortButton)
                setupSortButton()
            }
            if includesFilter {
                searchStackView.addArrangedSubview(filterButton)
                setupFilterButton()
            }
        }

        setupLabels()
        setupActionButtons()
        setupSearchField()
        leftBarButton?.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        rightBarButton?.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
    }

    private func setupLabels() {
        navigationTitle.text = title
        navigationSubtitle.text = subtitle
    }

    private func setupBackButton() {
        leftBarButton = backButton
    }

    private func setupActionButtons() {
        if let leftBarButton, leftBarButton.style == .icon {
            leftBarButton.translatesAutoresizingMaskIntoConstraints = false
            leftBarButton.setWidthHeightConstraints(24)
        }
        if let rightBarButton, rightBarButton.style == .icon {
            rightBarButton.translatesAutoresizingMaskIntoConstraints = false
            rightBarButton.setWidthHeightConstraints(24)
        }
    }

    private func setupSortButton() {
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.setWidthHeightConstraints(48)
        sortButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
    }

    private func setupFilterButton() {
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.setWidthHeightConstraints(48)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
    }

    private func setupSearchField() {
        searchField.delegate = self
    }


}

extension MehNavigationView {

    @objc 
    private func filterTapped(_ sender: MehButton) {
        searchDelegate?.filterTapped()
    }

    @objc 
    private func sortTapped(_ sender: MehButton) {
        searchDelegate?.sortTapped()
    }

    @objc
    private func leftBarButtonTapped(_ sender: MehButton) {
        actionDelegate?.leftButtonTapped()
    }

    @objc
    private func rightBarButtonTapped(_ sender: MehButton) {
        actionDelegate?.rightButtonTapped()
    }


}

extension MehNavigationView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchDelegate?.didSearch(for: textField, shouldChangeCharactersIn: range, replacementString: string) ?? false
    }

}
