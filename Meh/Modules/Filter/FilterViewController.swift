//
//  FilterViewController.swift
//  Meh
//
//  Created by Raj Raval on 06/02/24.
//

import UIKit

final class FilterViewController: UIViewController {

    private var filterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, layout: .headerWithRow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

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
        filterCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        filterCollectionView.register(MehHeaderSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MehHeaderSection.reuseIdentifier)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        view.addSubview(filterCollectionView)
        filterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterCollectionView.pinToLeadingAndTrailingEdgesWithConstant()
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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }

}

extension FilterViewController: UICollectionViewDelegate {
    
}
