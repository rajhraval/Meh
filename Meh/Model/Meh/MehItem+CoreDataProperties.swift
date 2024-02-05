//
//  MehItem+CoreDataProperties.swift
//  Meh
//
//  Created by Raj Raval on 30/01/24.
//
//

import Foundation
import CoreData


extension MehItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MehItem> {
        return NSFetchRequest<MehItem>(entityName: "MehItem")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var link: String
    @NSManaged public var price: Double
    @NSManaged public var accessibility: Double
    @NSManaged public var participants: Int16
    @NSManaged public var type: String
    @NSManaged public var color: String

    var emojis: String {
        let maxEmojisToShow = 4
        let baseEmojis = ["🙋‍♂️", "🙋‍♀️"]
        var result = ""
        let quantity = Int(participants)

        if quantity <= maxEmojisToShow {
            result = String(repeating: baseEmojis[Int.random(in: 0..<baseEmojis.count)], count: quantity)
        } else {
            result = String(repeating: "🙋‍♂️🙋‍♀️", count: maxEmojisToShow) + " +\(quantity - maxEmojisToShow)"
        }
        return result
    }

    var money: String {
        switch price {
        case 0.1..<0.5:
            return "💰"
        case 0.5:
            return "💰💰"
        case 0.6...1.0:
            return "💰💰💰"
        case 0:
            return "💸"
        default:
            return "🤷"
        }
    }

}

extension MehItem: Identifiable {

}

extension MehItem {
    static var alphabeticalFetch: NSFetchRequest<MehItem> {
        let fetchRequest = MehItem.fetchRequest()
        fetchRequest.sortDescriptors = [.sortDescriptor(\MehItem.name)]
        return fetchRequest
    }
}
