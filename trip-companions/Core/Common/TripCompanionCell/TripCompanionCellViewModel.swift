//
//  TripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation
import UIKit

class TripCompanionCellViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanionsWithRegionAndMember
    @Published var thumbnail: UIImage? = nil
//    @Published var title: String = ""
//    @Published var contents: String = ""
//    @Published var startDate: Date = Date()
//    @Published var endDate: Date = Date()
    
    init(tripCompanion: TripCompanionsWithRegionAndMember, thumbnail: UIImage?) {
        self.tripCompanion = tripCompanion
        self.thumbnail = thumbnail
//        self.title = title
//        self.contents = contents
//        self.startDate = startDate
//        self.endDate = endDate
    }
    
    func toDateText(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

extension TripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = TripCompanionCellViewModel(tripCompanion: TripCompanionsWithRegionAndMember.MOCK_TRIP_COMPANIONS[0], thumbnail: nil)
}
