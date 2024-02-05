//
//  NSPredicate+.swift
//  Meh
//
//  Created by Raj Raval on 04/02/24.
//

import CoreData

extension NSPredicate {

    static func byMatchingName(_ name: String) -> NSPredicate {
        NSPredicate(format: "name == %@", name as CVarArg)
    }

}
