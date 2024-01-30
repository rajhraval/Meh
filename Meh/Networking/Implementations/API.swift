//
//  API.swift
//  Meh
//
//  Created by Raj Raval on 30/01/24.
//

import Foundation

protocol API {
    func request<T: Codable>(_ endpoint: Endpoint) async throws -> T
}

extension API {
    func request<T: Codable>(_ endpoint: Endpoint) async throws -> T {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        if endpoint.method == .post {
            request.httpBody = endpoint.body
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw APIError.networkingError(error: NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: nil))
            }

            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch let error {
            throw APIError.decodingError(error: error)
        }
    }
}
