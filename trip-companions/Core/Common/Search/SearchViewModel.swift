//
//  SearchViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation
import Alamofire
import Combine

class SearchViewModel: ObservableObject {
    static let shared = SearchViewModel()
    
    @Published var region: Region? = nil
    @Published var startDate: Date? = nil
    @Published var isSameMbti: Bool? = nil
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    @Published var keyword: String = ""
    
    init(region: Region? = nil, startDate: Date? = nil, isSameMbti: Bool? = nil, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil, keyword: String = "") {
        self.region = region
        self.startDate = startDate
        self.isSameMbti = isSameMbti
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
        self.keyword = keyword
    }

    func clear() {
        region = nil
        startDate = nil
        isSameMbti = nil
        isMale = nil
        isDrinker = nil
        isSmoker = nil
        keyword = ""
    }
}

extension SearchViewModel {
    static let MOCK_VIEW_MODEL = SearchViewModel()
}
