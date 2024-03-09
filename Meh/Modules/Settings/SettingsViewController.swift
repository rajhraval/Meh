//
//  SettingsViewController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import UIKit

final class SettingsViewController: UIViewController {

    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()

    private var navigationView: MehNavigationView = {
        let navigationView = MehNavigationView()
        navigationView.title = "Settings"
        navigationView.subtitle = "Change your preferences"
        navigationView.includesSearchBar = true
        return navigationView
    }()

    private var testButton: MehButton = {
        let button = MehButton(style: .navigation)
        button.foregroundColour = .black
        button.title = "Reset"
        return button
    }()

    private var settingsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, layout: .singleRowWithHeader(header: true))
        return collectionView
    }()

    private var viewModel: SettingsViewModel!

    init(viewModel: SettingsViewModel = SettingsViewModel()) {
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
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(containerStackView)
        containerStackView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        setupNavigationView()
        setupCollectionView()
    }

    private func setupNavigationView() {
        containerStackView.addArrangedSubview(navigationView)
    }

    private func setupCollectionView() {
        containerStackView.addArrangedSubview(settingsCollectionView)
        settingsCollectionView.register(MehHeaderSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MehHeaderSection.reuseIdentifier)
        settingsCollectionView.register(SettingsListCell.self, forCellWithReuseIdentifier: SettingsListCell.reuseIdentifier)
        settingsCollectionView.register(MetaInfoViewCell.self, forCellWithReuseIdentifier: MetaInfoViewCell.reuseIdentifier)
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
    }

}

extension SettingsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        switch section {
        case .about:
            return 3
        case .meta:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .about:
            let item = AboutItem.items[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsListCell.reuseIdentifier, for: indexPath) as? SettingsListCell else { fatalError("Cannot dequeue FavoriteListCell") }
            cell.configureCell(with: item)
            return cell
        case .meta:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetaInfoViewCell.reuseIdentifier, for: indexPath) as? MetaInfoViewCell else { fatalError("Cannot dequeue FavoriteListCell") }
            return cell
        }
    }

}

extension SettingsViewController: UICollectionViewDelegate {


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
