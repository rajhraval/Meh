//
//  HomeViewModel.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Combine
import Foundation
import UIKit.UIColor

enum LoadingState {
    case idle
    case loading
    case error
}

final class HomeViewModel: ObservableObject {

    @Published var activity: Activity?
    @Published var loadingState: LoadingState = .loading

    private let activityService: ActivityService

    init(activityService: ActivityService = ActivityService()) {
        self.activityService = activityService
        fetchActivity()
    }

    func fetchActivity(
        type: String? = nil,
        participants: Int? = nil,
        price: Double? = nil,
        minPrice: Double? = nil,
        maxPrice: Double? = nil,
        accessibility: Double? = nil,
        minAccessibility: Double? = nil,
        maxAccessibility: Double? = nil
    ) {
        Task {
            do {
                self.activity = try await activityService.fetchActivity(
                    type: type,
                    participants: participants,
                    price: price,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    accessibility: accessibility,
                    minAccessibility: minAccessibility,
                    maxAccessibility: maxAccessibility
                ) as Activity
                loadingState = .idle
            } catch let error {
                loadingState = .error
                Log.error(error)
            }
        }
    }

    func addActivity(_ activity: Activity, with color: UIColor) {
        CoreDataStack.shared.addMehItem(
            id: activity.id,
            name: activity.name,
            type: activity.type,
            participants: Int(activity.participants),
            price: activity.price,
            accessibility: activity.accessibility,
            link: activity.link,
            color: color
        )
        NotificationCenter.default.post(name: .addActivity, object: nil)
    }
}
