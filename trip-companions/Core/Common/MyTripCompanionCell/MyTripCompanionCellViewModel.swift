//
//  MyTripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import Foundation
import UIKit

class MyTripCompanionCellViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
    
    func deleteTripCompanion() {
        
    }
    
}

extension MyTripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = MyTripCompanionCellViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])
}
