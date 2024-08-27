//
//  WriteTripCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/18/24.
//

import Foundation

class WriteTripCompanionViewModel: ObservableObject {
    @Published var region: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var startDate = Date.defaultDate() {
        didSet {
            validateForm()
        }
    }
    @Published var endDate = Date.defaultDate() {
        didSet {
            validateForm()
        }
    }
    @Published var personal: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var contents: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var isSameMbti: Bool? = nil
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    
    @Published var isComplete: Bool = false

    private func validateForm() {
        isComplete = !region.isEmpty &&
        startDate != Date.defaultDate() &&
        endDate != Date.defaultDate() &&
        personal != nil &&
        !contents.isEmpty
    }
    
    init(region: String = "", startDate: Date, endDate: Date, personal: String = "", contents: String = "", isSameMbti: Bool? = nil, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil) {
        self.region = region
        self.startDate = startDate
        self.endDate = endDate
        self.personal = personal
        self.contents = contents
        self.isSameMbti = isSameMbti
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
    }
    
}

extension WriteTripCompanionViewModel {
    static let MOCK_VIEW_MODEL = WriteTripCompanionViewModel(startDate: Date.defaultDate(), endDate: Date.defaultDate())
}
