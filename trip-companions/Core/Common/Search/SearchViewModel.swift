//
//  SearchViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var regionName: String = ""
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    @Published var detail: String = ""

    init(regionName: String, startDate: Date, endDate: Date, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil, detail: String) {
        self.regionName = regionName
        self.startDate = startDate
        self.endDate = endDate
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
        self.detail = detail
    }
}

extension SearchViewModel {
    static let MOCK_VIEW_MODEL = SearchViewModel(regionName: "", startDate: Date.defaultDate(), endDate: Date.defaultDate(), detail: "")
}
