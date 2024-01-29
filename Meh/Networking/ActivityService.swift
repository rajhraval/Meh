//
//  ActivityService.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

protocol API {
    associatedtype ResponseType
    func request<ResponseType: Codable>(_ endpoint: Endpoint) async throws -> ResponseType
}

final class ActivityService: API {

    typealias ResponseType = Activity

    func request<ResponseType: Codable>(_ endpoint: Endpoint) async throws -> ResponseType {
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

            let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: data)
            return decodedResponse
        } catch let error {
            throw APIError.decodingError(error: error)
        }
    }

}
