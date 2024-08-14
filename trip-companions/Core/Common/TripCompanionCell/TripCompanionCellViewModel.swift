//
//  TripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation
import UIKit

class TripCompanionCellViewModel: ObservableObject {
    @Published var thumbnail: UIImage? = nil
    @Published var title: String = ""
    @Published var text: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    
    init(thumbnail: UIImage?, title: String, text: String, startDate: Date, endDate: Date) {
        self.thumbnail = thumbnail
        self.title = title
        self.text = text
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func toDateText(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

extension TripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = TripCompanionCellViewModel(thumbnail: nil, title: "오늘 부산 앞바다 야경", text: "오늘 광안리에서 만나실 분!", startDate: Date(), endDate: Date())
}
