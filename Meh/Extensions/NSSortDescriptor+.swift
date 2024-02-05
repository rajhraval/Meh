//
//  NSSortDescriptor+.swift
//  Meh
//
//  Created by Raj Raval on 04/02/24.
//

import CoreData

extension NSSortDescriptor {
    static func sortDescriptor<T>(_ keyPath: KeyPath<T, some Comparable>, ascending: Bool = true) -> NSSortDescriptor {
        return NSSortDescriptor(keyPath: keyPath, ascending: ascending)
    }
}
