//
//  DomesticCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class DomesticCompanionViewModel: ObservableObject {
    @Published var tripCompanions: [TripCompanionsWithRegionAndMember]
    @Published var filters: [String] = []
    
    init(tripCompanions: [TripCompanionsWithRegionAndMember]) {
        self.tripCompanions = tripCompanions
    }
    
    func addFilter() {
        
    }

}

extension DomesticCompanionViewModel {
    static let MOCK_VIEW_MODEL: DomesticCompanionViewModel = DomesticCompanionViewModel(tripCompanions: TripCompanionsWithRegionAndMember.MOCK_TRIP_COMPANIONS)
}
