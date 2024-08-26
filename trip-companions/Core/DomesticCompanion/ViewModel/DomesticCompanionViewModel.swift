//
//  DomesticCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class DomesticCompanionViewModel: ObservableObject {
    @Published var tripCompanions: [TripCompanion]
    @Published var filters: [String] = []
    
    init(tripCompanions: [TripCompanion]) {
        self.tripCompanions = tripCompanions
    }
    
    func addFilter() {
        
    }

}

extension DomesticCompanionViewModel {
    static let MOCK_VIEW_MODEL: DomesticCompanionViewModel = DomesticCompanionViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
