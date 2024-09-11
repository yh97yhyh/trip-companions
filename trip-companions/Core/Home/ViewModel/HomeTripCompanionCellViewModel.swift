//
//  HomeTripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/12/24.
//

import Foundation

class HomeTripCompanionCellViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
}

extension HomeTripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = HomeTripCompanionCellViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])
}
