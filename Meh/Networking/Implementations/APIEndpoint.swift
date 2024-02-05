//
//  APIEndpoint.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var method: HTTPRequestMethod { get }
    var body: Data { get }
    var queryItems: [URLQueryItem]? { get }
}

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIEndpoint: Endpoint {
    case activity(
        type: String?,
        participants: Int?,
        price: Double?,
        minPrice: Double?,
        maxPrice: Double?,
        accessibility: Double?,
        minAccessibility: Double?,
        maxAccessibility: Double?
    )

    var baseURL: URL {
        guard let url = URL(string: "http://www.boredapi.com/api/") else {
            fatalError("Invalid Base URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .activity:
            return "activity"
        }
    }

    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }

    var method: HTTPRequestMethod {
        switch self {
        case .activity:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .activity(let type, let participants, let price, let minPrice, let maxPrice, let accessibility, let minAccessibility, let maxAccessibility):
            let queryItems = [
                URLQueryItem(name: "type", value: type),
                optionalQueryItem(name: "participants", value: participants),
                optionalQueryItem(name: "price", value: price),
                optionalQueryItem(name: "minPrice", value: minPrice),
                optionalQueryItem(name: "maxPrice", value: maxPrice),
                optionalQueryItem(name: "accessibility", value: accessibility),
                optionalQueryItem(name: "minAccessibility", value: minAccessibility),
                optionalQueryItem(name: "maxAccessibility", value: maxAccessibility)
            ]
            return createQueryItems(queryItems)
        }
    }

    private func optionalQueryItem(name: String, value: (any Numeric)?) -> URLQueryItem? {
        guard let value = value else { return nil }
        return URLQueryItem(name: name, value: "\(value)")
    }

    private func createQueryItems(_ items: [URLQueryItem?]) -> [URLQueryItem]? {
        return items.compactMap { $0 }
    }

    var body: Data {
        return Data()
    }
}



