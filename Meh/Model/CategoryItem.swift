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
    let image: String
    let color: UIColor
}

extension CategoryItem {
    static var items = [
        CategoryItem(name: "education", image: "books.vertical.fill", color: .systemIndigo),
        CategoryItem(name: "recreational", image: "balloon.2.fill", color: .systemOrange),
        CategoryItem(name: "social", image: "person.3.fill", color: .systemGreen),
        CategoryItem(name: "diy", image: "wand.and.stars.inverse", color: .systemPurple),
        CategoryItem(name: "charity", image: "dollarsign.circle.fill", color: .systemPink),
        CategoryItem(name: "cooking", image: "frying.pan", color: .systemCyan),
        CategoryItem(name: "relaxation", image: "zzz", color: .systemMint),
        CategoryItem(name: "music", image: "guitars", color: .systemYellow),
        CategoryItem(name: "busywork", image: "brain.head.profile", color: .systemRed)
    ]
}
