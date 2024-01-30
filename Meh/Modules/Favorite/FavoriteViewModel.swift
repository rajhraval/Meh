//
//  FavoriteViewModel.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import Foundation

final class FavoriteViewModel: ObservableObject {
    
    @Published var favorites: [MehItem] = []

    init() {
        fetchFavorites()
    }

    func fetchFavorites() {
        favorites = CoreDataStack.shared.fetch(MehItem.self)
    }

    func deleteFavorite(_ item: MehItem) {
        CoreDataStack.shared.delete(item)
        fetchFavorites()
    }

}
