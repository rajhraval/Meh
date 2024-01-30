//
//  APIError.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

enum APIError: Error {
    case networkingError(error: Error)
    case decodingError(error: Error)
}
