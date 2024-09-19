//
//  MyInterestingTripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import Foundation

class MyInterestingTripCompanionCellViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
}

extension MyInterestingTripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = MyInterestingTripCompanionCellViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])

}
