//
//  TripCompanionDetailViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class TripCompanionDetailViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion

    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
}

extension TripCompanionDetailViewModel{
    static let MOCK_VIEW_MODEL = TripCompanionDetailViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANION2)
}
