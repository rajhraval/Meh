//
//  CategoryItem.swift
//  Meh
//
//  Created by Raj Raval on 07/02/24.
//

import UIKit.UIColor

struct CategoryItem: Identifiable {
    let id = UUID()
    let name: String
    let color: UIColor
}

extension CategoryItem {
    static var items = [
        CategoryItem(name: "education", color: .systemIndigo),
        CategoryItem(name: "recreational", color: .systemOrange),
        CategoryItem(name: "social", color: .systemGreen),
        CategoryItem(name: "diy", color: .systemPurple),
        CategoryItem(name: "charity", color: .systemPink),
        CategoryItem(name: "cooking", color: .systemCyan),
        CategoryItem(name: "relaxation", color: .systemMint),
        CategoryItem(name: "music", color: .systemYellow),
        CategoryItem(name: "busywork", color: .systemBlue)
    ]
}
