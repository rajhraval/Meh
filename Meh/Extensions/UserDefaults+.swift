//
//  UserDefaults+.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

enum UserDefaultKey: String {
    case test
}

extension UserDefaults {

    static var defaults: UserDefaults {
        return UserDefaults(suiteName: Constants.appGroup) ?? .standard
    }

    func set(_ value: Any, for key: UserDefaultKey) {
        self.set(value, forKey: key.rawValue)
    }

    func date(for key: UserDefaultKey) -> Date {
        return self.object(forKey: key.rawValue) as? Date ?? Date.now
    }

    func bool(for key: UserDefaultKey) -> Bool {
        return self.bool(forKey: key.rawValue)
    }

    func data(for key: UserDefaultKey) -> Data? {
        return self.data(forKey: key.rawValue)
    }

    func string(for key: UserDefaultKey) -> String? {
        return self.string(forKey: key.rawValue)
    }

    func integer(for key: UserDefaultKey) -> Int? {
        return self.integer(forKey: key.rawValue)
    }

    func float(for key: UserDefaultKey) -> Float? {
        return self.float(forKey: key.rawValue)
    }

    func url(for key: UserDefaultKey) -> URL? {
        return self.url(forKey: key.rawValue)
    }

    func value(for key: UserDefaultKey) -> Any? {
        return self.value(forKey: key.rawValue)
    }
}

