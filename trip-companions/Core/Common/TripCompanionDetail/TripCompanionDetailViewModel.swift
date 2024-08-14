//
//  TripCompanionDetailViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class TripCompanionDetailViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanionsWithRegionAndMember

    init(tripCompanion: TripCompanionsWithRegionAndMember) {
        self.tripCompanion = tripCompanion
    }
}

extension TripCompanionDetailViewModel{
    static let MOCK_VIEW_MODEL = TripCompanionDetailViewModel(tripCompanion: TripCompanionsWithRegionAndMember.MOCK_TRIP_COMPANION2)
}
