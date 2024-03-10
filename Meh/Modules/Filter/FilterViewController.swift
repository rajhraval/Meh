//
//  FilterViewController.swift
//  Meh
//
//  Created by Raj Raval on 10/03/24.
//

import UIKit

class FilterViewController: MehCollectionViewController {

    typealias ViewModel = FilterViewModel

    private var resetButton: MehButton = {
        let resetButton = MehButton(style: .navigation)
        resetButton.title = "Reset"
        resetButton.foregroundColour = .systemIndigo
        return resetButton
    }()

    private var viewModel: ViewModel!

    init(viewModel: FilterViewModel = FilterViewModel()) {
        super.init()
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupView() {
        super.setupView()
        layout = createLayout()
        navigationView.title = "Filter"
        navigationView.subtitle = "You can get what you want"
        navigationView.includesBackButton = true
        navigationView.rightBarButton = resetButton
        navigationView.actionDelegate = self
        collectionView.registerCells([FilterCategoryItemCell.self, UICollectionViewCell.self])
        collectionView.registerSupplementaryView([MehHeaderSection.self], ofKind: UICollectionView.elementKindSectionHeader)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let filterSection = FilterSection(rawValue: sectionIndex) else { return nil }

            let itemSize = NSCollectionLayoutSize(widthDimension: filterSection.itemWidth, heightDimension: filterSection.itemHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: filterSection.groupWidth, heightDimension: filterSection.groupHeight)
            let group = filterSection == .category ? NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) : NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
            return section
        }
        return layout
    }

}

extension FilterViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        return section.numberOfItems
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .category:
            let item = CategoryItem.items[indexPath.item]
            let cell: FilterCategoryItemCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(for: item)
            cell.didSelectCategory = { [weak self] categoryName in
                guard let self = self else { return }
                Log.info("Category: \(categoryName)")
            }
            return cell
        default:
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.sections[indexPath.section]
        let header: MehHeaderSection = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
        header.configureHeader(for: section)
        return header
    }

}

extension FilterViewController: MehNavigationActionDelegate {

    func leftButtonTapped() {
        dismiss(animated: true)
    }

    func rightButtonTapped() {

    }

}
