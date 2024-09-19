//
//  DomesticCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation
import Alamofire
import Combine

class DomesticCompanionViewModel: ObservableObject {
    static let shared = DomesticCompanionViewModel()
    
    @Published var tripCompanions: [TripCompanion] = []
    
    @Published var region: Region? = nil
    @Published var startDate: Date? = nil
    @Published var isSameMbti: Bool? = nil
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    @Published var isComplete: Bool = false

    private var fetchCount = 0
    private var page = 1
    private var totalPages = 0
    @Published var isFetching = true
    
    init(tripCompanions: [TripCompanion] = [], region: Region? = nil, startDate: Date? = nil, isSameMbti: Bool? = nil, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil) {
        self.tripCompanions = tripCompanions
        self.region = region
        self.startDate = startDate
        self.isSameMbti = isSameMbti
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
        
//        fetchTripUnion()
    }
}

extension DomesticCompanionViewModel {
    static let MOCK_VIEW_MODEL: DomesticCompanionViewModel = DomesticCompanionViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS, startDate: Date.defaultDate())
}
