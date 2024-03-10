//
//  SettingsViewController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import UIKit

final class SettingsViewController: MehCollectionViewController {

    typealias ViewModel = SettingsViewModel

    private var viewModel: ViewModel!

    init(viewModel: SettingsViewModel = SettingsViewModel()) {
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
        navigationView.title = "Settings"
        navigationView.subtitle = "Change your preferences"
        layout = LayoutType.singleRowWithHeader(header: true).layout
        setupCollectionViewCells()
    }

    private func setupCollectionViewCells() {
        collectionView.registerSupplementaryView([MehHeaderSection.self], ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.registerCells([SettingsListCell.self, MetaInfoViewCell.self])
    }

}

extension SettingsViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .about, .meta:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MehHeaderSection.reuseIdentifier, for: indexPath) as? MehHeaderSection else {
                fatalError("Cannot dequeue MehHeaderSection")
            }
            header.configureHeader(for: section)
            return header
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        switch section {
        case .about:
            return 3
        case .meta:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .about:
            let item = AboutItem.items[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsListCell.reuseIdentifier, for: indexPath) as? SettingsListCell else { fatalError("Cannot dequeue FavoriteListCell") }
            cell.configureCell(with: item)
            return cell
        case .meta:
            let cell: MetaInfoViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }

}

extension SettingsViewController {


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .about:
            let item = AboutItem.items[indexPath.item]
            Task { @MainActor in
                UIApplication.shared.open(item.link)
            }
        case .meta:
            break
        }
    }

}
