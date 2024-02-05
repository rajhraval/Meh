//
//  AboutItem.swift
//  Meh
//
//  Created by Raj Raval on 05/02/24.
//

import UIKit.UIColor
import Foundation

struct AboutItem: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let color: UIColor
    let link: URL
}

extension AboutItem {
    static let items = [
        AboutItem(title: "Developer", image: "person.fill", color: .systemOrange, link: URL(string: "https://twitter.com/rajhraval")!),
        AboutItem(title: "README.md", image: "note.text", color: .systemIndigo, link: URL(string: "https://github.com/rajhraval/Meh/blob/develop/README.md")!),
        AboutItem(title: "Report Bug", image: "ladybug.fill", color: .systemRed, link: URL(string: "https://github.com/rajhraval/Meh/issues")!)
    ]
}
