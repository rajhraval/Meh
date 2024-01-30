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

}

extension MehItem : Identifiable {

}
