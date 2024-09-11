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
//    @Published var endDate: Date {
//        didSet {
//            validateForm()
//        }
//    }
    @Published var isSameMbti: Bool? = nil
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    
    var cancellables = Set<AnyCancellable>()

    init(region: Region? = nil, startDate: Date? = nil, isSameMbti: Bool? = nil, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil) {
        self.region = region
        self.startDate = startDate
        self.isSameMbti = isSameMbti
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
    }
    
    func fetchTripUnion() {
        var categoriesId: [Int] = []
        
        if isSameMbti != nil {
            isSameMbti! ? categoriesId.append(1) : categoriesId.append(2)
        }
        if isMale != nil {
            isMale! ? categoriesId.append(3) : categoriesId.append(4)
        }
        if isDrinker != nil {
            isDrinker! ? categoriesId.append(5) : categoriesId.append(6)
        }
        if isSmoker != nil {
            isSmoker! ? categoriesId.append(7) : categoriesId.append(8)
        }
        
        var parameters: [String: Any] = [
            "categories": categoriesId,
            "page": 1
        ]

        if let regionId = region?.id {
            parameters["regionId"] = regionId
        }

        if let startDate = startDate {
            parameters["tripDate"] = startDate.toServerDateText()
        }
        
        NetworkManager<TripCompanionResponse>.request(route: .fetchTripCompanions(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request fetchTripCompanions!")
                case .failure(let error):
                    print("Failed to request fetchTripCompanions.. \(error.localizedDescription)")
                }
            } receiveValue: { tripCompanionResponse in
                print(tripCompanionResponse.data)
            }.store(in: &cancellables)
    }
    
    func clear() {
        region = nil
        startDate = nil
        isSameMbti = nil
        isMale = nil
        isDrinker = nil
        isSmoker = nil
    }
}

extension SearchViewModel {
    static let MOCK_VIEW_MODEL = SearchViewModel()
}
