//
//  Activity.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

struct Activity: Identifiable, Codable {
    let id: String
    let name: String
    let type: String
    let participants: Int
    let price: Double
    let accessibility: Double
    let link: String

    var showLink: Bool {
        link.isEmpty ? false : true
    }

    enum CodingKeys: String, CodingKey {
        case id = "key"
        case name = "activity"
        case type, participants, accessibility, price
        case link
    }

    init(from item: MehItem) {
        id = item.id
        name = item.name
        type = item.type
        participants = Int(item.participants)
        price = item.price
        accessibility = item.accessibility
        link = item.link
    }
}
