//
//  FavoriteViewModel.swift
//  Meh
//
//  Created by Raj Raval on 29/01/24.
//

import CoreData
import Foundation

final class FavoriteViewModel: ObservableObject {
    
    @Published var filteredFavorites: [MehItem] = []
    @Published var favorites: [MehItem] = []
    @Published var isSearching: Bool = false

    init() {
        fetchFavorites()
    }

    func fetchFavorites() {
        favorites = CoreDataStack.shared.fetch(MehItem.self)
        filteredFavorites = favorites
    }

    func fetchFromSearch(_ text: String) {
        filteredFavorites = favorites
        Log.info("Before Filtered Favorites: \(filteredFavorites.count)")
        isSearching = true
        guard !text.isEmpty else {
            isSearching = false
            filteredFavorites = favorites
            return
        }
        filteredFavorites = filteredFavorites.filter { $0.name.range(of: text, options: .caseInsensitive) != nil }
        Log.info("After Filtered Favorites: \(filteredFavorites.count)")
    }

    func deleteFavorite(_ item: MehItem) {
        CoreDataStack.shared.delete(item)
        fetchFavorites()
    }

}
