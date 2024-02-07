//
//  FilterViewController.swift
//  Meh
//
//  Created by Raj Raval on 06/02/24.
//

import UIKit

final class FilterViewController: UIViewController {

    private var filterCollectionView: UICollectionView!

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private var resetButton: MehButton = {
        let button = MehButton(style: .text)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColour = .systemMint
        button.title = "Reset"
        return button
    }()

    private var applyButton: MehButton = {
        let button = MehButton(style: .text)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColour = .systemIndigo
        button.title = "Apply"
        return button
    }()

    private var dismissButton: MehButton = {
        let button = MehButton(style: .icon)
        button.image = UIImage(systemName: "xmark.circle.fill")!
        button.foregroundColour = .orange
        return button
    }()

    private var viewModel: FilterViewModel!

    init(viewModel: FilterViewModel = FilterViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setup() {
        title = "Filter"
        view.backgroundColor = .systemBackground
        setupView()
    }

    private func setupView() {
        setupCollectionView()
        setupButtonStackViewConstraints()
        setupDismissButton()
    }

    private func setupDismissButton() {
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: dismissButton)
        navigationItem.rightBarButtonItem = rightButton
    }

    private func setupCollectionView() {
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        filterCollectionView.register(CategoryItemCell.self, forCellWithReuseIdentifier: CategoryItemCell.reuseIdentifier)
        filterCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        filterCollectionView.register(MehHeaderSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MehHeaderSection.reuseIdentifier)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        view.addSubview(filterCollectionView)
        filterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterCollectionView.pinToLeadingAndTrailingEdgesWithConstant()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let layoutType = FilterViewModel.FilterSection(rawValue: sectionIndex) else { return nil }

            let itemSize = NSCollectionLayoutSize(widthDimension: layoutType.itemWidth, heightDimension: layoutType.itemHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0)

            let groupSize = NSCollectionLayoutSize(widthDimension: layoutType.groupWidth, heightDimension: layoutType.groupHeight)
            let group = layoutType == .category ? NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) : NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(8)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
    }

    private func setupButtonStackViewConstraints() {
        view.addSubview(buttonStackView)
        buttonStackView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 16).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonStackView.pinToLeadingAndTrailingEdgesWithConstant(16)
        buttonStackView.addArrangedSubviews(resetButton, applyButton)
    }

    @objc
    func dismissView(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

extension FilterViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.sections[indexPath.section]
        switch section {
        default:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MehHeaderSection.reuseIdentifier, for: indexPath) as? MehHeaderSection else {
                fatalError("Cannot dequeue MehHeaderSection")
            }
            header.configureFilterHeader(for: section)
            return header
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        return section.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .category:
            let item = CategoryItem.items[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCell.reuseIdentifier, for: indexPath) as? CategoryItemCell else {
                fatalError("Cannot dequeue CategoryItemCell")
            }
            cell.configureCell(for: item)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return cell
        }

    }

}

extension FilterViewController: UICollectionViewDelegate {
    
}
