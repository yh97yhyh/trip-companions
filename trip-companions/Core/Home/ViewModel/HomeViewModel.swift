//
//  HomeViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var tripCompanions: [TripCompanion]
    
    init(tripCompanions: [TripCompanion]) {
        self.tripCompanions = tripCompanions
    }
}

extension HomeViewModel {
    static let MOCK_VIEW_MODEL: HomeViewModel = HomeViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
