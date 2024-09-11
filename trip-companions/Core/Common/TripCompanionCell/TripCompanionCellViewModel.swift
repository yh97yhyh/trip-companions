//
//  TripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation
import UIKit

class TripCompanionCellViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
//    @Published var title: String = ""
//    @Published var contents: String = ""
//    @Published var startDate: Date = Date()
//    @Published var endDate: Date = Date()
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
//        self.title = title
//        self.contents = contents
//        self.startDate = startDate
//        self.endDate = endDate
    }
    
}

extension TripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = TripCompanionCellViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])
}
