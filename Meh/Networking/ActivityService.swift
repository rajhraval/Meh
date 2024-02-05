//
//  ActivityService.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation

final class ActivityService: API {

    func fetchActivity(
        type: String? = nil,
        participants: Int? = nil,
        price: Double? = nil,
        minPrice: Double? = nil,
        maxPrice: Double? = nil,
        accessibility: Double? = nil,
        minAccessibility: Double? = nil,
        maxAccessibility: Double? = nil
    ) async throws -> Activity {
        try await request(
            APIEndpoint.activity(
                type: type,
                participants: participants,
                price: price,
                minPrice: minPrice,
                maxPrice: maxPrice,
                accessibility: accessibility,
                minAccessibility: minAccessibility,
                maxAccessibility: maxAccessibility
            )
        )
    }

}
