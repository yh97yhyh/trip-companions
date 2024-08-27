//
//  SearchViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var regionName: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var startDate: Date {
        didSet {
            validateForm()
        }
    }
    @Published var endDate: Date {
        didSet {
            validateForm()
        }
    }
    @Published var isSameMbti: Bool? = nil
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
//    @Published var detail: String = ""
    
    @Published var isComplete: Bool = false

    private func validateForm() {
        isComplete = !regionName.isEmpty &&
        startDate != Date.defaultDate() &&
        endDate != Date.defaultDate()
    }

    init(regionName: String, startDate: Date, endDate: Date, isSameMbti: Bool? = nil, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil) {
        self.regionName = regionName
        self.startDate = startDate
        self.endDate = endDate
        self.isSameMbti = isSameMbti
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
//        self.detail = detail
    }
    
    func clear() {
        regionName = ""
        startDate = Date.defaultDate()
        endDate = Date.defaultDate()
        isSameMbti = nil
        isMale = nil
        isDrinker = nil
        isSmoker = nil
    }
}

extension SearchViewModel {
    static let MOCK_VIEW_MODEL = SearchViewModel(regionName: "", startDate: Date.defaultDate(), endDate: Date.defaultDate())
}
