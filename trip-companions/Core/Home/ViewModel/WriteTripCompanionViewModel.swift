//
//  WriteTripCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/18/24.
//

import Foundation

class WriteTripCompanionViewModel: ObservableObject {
    @Published var region: String = ""
    @Published var startDate = Date.defaultDate()
    @Published var endDate = Date.defaultDate()
    @Published var personal: Int? = nil
    @Published var contents: String = ""
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    @Published var detail: String = ""
    
    init(region: String = "", startDate: Date, endDate: Date, personal: Int? = nil, contents: String = "", isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil, detail: String = "") {
        self.region = region
        self.startDate = startDate
        self.endDate = endDate
        self.personal = personal
        self.contents = contents
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
        self.detail = detail
    }
    
}

extension WriteTripCompanionViewModel {
    static let MOCK_VIEW_MODEL = WriteTripCompanionViewModel(startDate: Date.defaultDate(), endDate: Date.defaultDate())
}
