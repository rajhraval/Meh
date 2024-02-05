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

    private var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "No Favorites?"
        view.subtitle = "Time to add one :)"
        return view
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
        setupEmptyState()
        setupSearchField()
        setupCollectionView()
    }

    private func setupSearchField() {
        view.addSubview(searchStackView)
        searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        searchStackView.addArrangedSubviews(searchTextField)
        searchTextField.delegate = self
        [searchTextField].forEach { $0.heightAnchor.constraint(equalToConstant: 48).isActive = true }
    }

    private func setupEmptyState() {
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        emptyStateView.centerInSuperview()
    }

    private func setupCollectionView() {
        favoriteCollectionView.register(FavoriteListCell.self, forCellWithReuseIdentifier: FavoriteListCell.reuseIdentifier)
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
                show(isEmpty: favoriteItems.isEmpty)
            }
            .store(in: &cancellables)
        viewModel.$filteredFavorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favoriteItems in
                guard let self = self else { return }
                show(isEmpty: favoriteItems.isEmpty, isFiltering: viewModel.isSearching)
            }
            .store(in: &cancellables)
    }

    private func show(isEmpty: Bool, isFiltering: Bool = false) {
        if isEmpty {
            if isFiltering {
                emptyStateView.title = "No results found :("
                emptyStateView.subtitle = "Maybe it might be something else."
            }
            emptyStateView.isHidden = false
            favoriteCollectionView.isHidden = true
        } else {
            favoriteCollectionView.isHidden = false
            favoriteCollectionView.reloadData()
        }
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
        return viewModel.isSearching ? viewModel.filteredFavorites.count : viewModel.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favorites = viewModel.isSearching ? viewModel.filteredFavorites : viewModel.favorites
        let favourite = favorites[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteListCell.reuseIdentifier, for: indexPath) as? FavoriteListCell else { fatalError("Cannot dequeue FavoriteListCell") }
        cell.configureCell(for: favourite)
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.6) {
                cell.alpha = 0
            } completion: { _ in
                self.viewModel.deleteFavorite(favourite)
            }
        }
        cell.shareAction = { [weak self] in
            guard let self = self else { return }
            shareImage(for: favourite)
        }
        return cell
    }

    private func shareImage(for item: MehItem) {
        let vc = ShareViewController(item: item)
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true)
    }

}


extension FavoriteViewController: UICollectionViewDelegate {

}

extension FavoriteViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let searchText = (currentText as NSString).replacingCharacters(in: range, with: string)
        viewModel.fetchFromSearch(searchText)
        return true
    }

}
