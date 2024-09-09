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
    @Published var thumbnail: UIImage? = nil
//    @Published var title: String = ""
//    @Published var contents: String = ""
//    @Published var startDate: Date = Date()
//    @Published var endDate: Date = Date()
    
    init(tripCompanion: TripCompanion, thumbnail: UIImage?) {
        self.tripCompanion = tripCompanion
        self.thumbnail = thumbnail
//        self.title = title
//        self.contents = contents
//        self.startDate = startDate
//        self.endDate = endDate
    }
    
}

extension MyTripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = MyTripCompanionCellViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0], thumbnail: nil)
}