//
//  FavoriteViewController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import Combine
import CoreData
import UIKit

final class FavoriteViewController: UIViewController {

    static let reuseIdentifier = "FavoriteListCell"

    private var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private var filterButton: MehButton = {
        let button = MehButton(style: .symbol)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColour = .systemIndigo
        button.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")!
        return button
    }()

    private var searchTextField: MehTextField = {
        let textfield = MehTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Search"
        return textfield
    }()

    private var favoriteCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, layout: .singleRow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var favorites: [MehItem] = []
    private var viewModel: FavoriteViewModel!
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: FavoriteViewModel = FavoriteViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .addActivity, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func setup() {
        title = "Favorites"
        view.backgroundColor = .systemBackground
        setupView()
        bind()
    }

    private func setupView() {
        setupSearchField()
        setupCollectionView()
    }

    private func setupSearchField() {
        view.addSubview(searchStackView)
        searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        searchStackView.addArrangedSubviews(searchTextField, filterButton)
        searchTextField.delegate = self
        [searchTextField, filterButton].forEach { $0.heightAnchor.constraint(equalToConstant: 48).isActive = true }
    }

    private func setupCollectionView() {
        favoriteCollectionView.register(FavoriteListCell.self, forCellWithReuseIdentifier: Self.reuseIdentifier)
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        view.addSubview(favoriteCollectionView)
        favoriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        favoriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        favoriteCollectionView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 16).isActive = true
        favoriteCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func bind() {
        viewModel.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favoriteItems in
                guard let self = self else { return }
                favorites = favoriteItems
                favoriteCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }

    @objc func refresh() {
        viewModel.fetchFavorites()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .addActivity, object: nil)
    }

}


extension FavoriteViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favourite = favorites[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reuseIdentifier, for: indexPath) as? FavoriteListCell else { fatalError("Cannot dequeue FavoriteListCell") }
        cell.configureCell(for: favourite)
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            viewModel.deleteFavorite(favourite)
        }
        return cell
    }

}


extension FavoriteViewController: UICollectionViewDelegate {

}

extension FavoriteViewController: UITextFieldDelegate {

}
