//
//  FavoriteViewController.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import Combine
import CoreData
import UIKit

final class FavoriteViewController: MehCollectionViewController {

    typealias ViewModel = FavoriteViewModel

    private var viewModel: ViewModel!
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: FavoriteViewModel = FavoriteViewModel()) {
        super.init()
        self.viewModel = viewModel
        bind()
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .addActivity, object: nil)
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
        navigationView.title = "Favorites"
        navigationView.subtitle = "The ones you like the most"
        navigationView.includesSearchBar = true
        navigationView.searchDelegate = self
        emptyStateView.title = "No Favorites"
        emptyStateView.subtitle = "Time to add one :)"
        collectionView.registerCells([FavoriteListCell.self])
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
            collectionView.isHidden = true
        } else {
            emptyStateView.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }

    @objc func refresh() {
        viewModel.fetchFavorites()
    }

}


extension FavoriteViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.isSearching ? viewModel.filteredFavorites.count : viewModel.favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favorites = viewModel.isSearching ? viewModel.filteredFavorites : viewModel.favorites
        let favourite = favorites[indexPath.item]
        let cell: FavoriteListCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
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
        present(vc, animated: true)
    }

}


extension FavoriteViewController {

}

extension FavoriteViewController: MehNavigationSearchDelegate {


    func sortTapped() {
        
    }

    func filterTapped() {

    }

    func didSearch(for textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let searchText = (currentText as NSString).replacingCharacters(in: range, with: string)
        viewModel.fetchFromSearch(searchText)
        return true
    }

}
