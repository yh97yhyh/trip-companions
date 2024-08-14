//
//  HomeViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var tripCompanions: [TripCompanionsWithRegionAndMember]
    
    init(tripCompanions: [TripCompanionsWithRegionAndMember]) {
        self.tripCompanions = tripCompanions
    }
}

extension HomeViewModel {
    static let MOCK_VIEW_MODEL: HomeViewModel = HomeViewModel(tripCompanions: TripCompanionsWithRegionAndMember.MOCK_TRIP_COMPANIONS)
}
