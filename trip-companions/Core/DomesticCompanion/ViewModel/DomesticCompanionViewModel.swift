//
//  DomesticCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation
import Alamofire
import Combine

class DomesticCompanionViewModel: ObservableObject {
    static let shared = DomesticCompanionViewModel()
    
    @Published var tripCompanions: [TripCompanion] = []

    private var fetchCount = 0
    private var page = 1
    private var totalPages = 0
    @Published var isFetching = true
    
    var cancellables = Set<AnyCancellable>()
    
    init(tripCompanions: [TripCompanion] = []) {
        self.tripCompanions = tripCompanions
        
        fetchTripCompanions()
    }
    
    func fetchTripCompanions() {
        var categoriesId: [Int] = []
        
        if SearchViewModel.shared.isSameMbti != nil {
            SearchViewModel.shared.isSameMbti! ? categoriesId.append(1) : categoriesId.append(2)
        }
        if SearchViewModel.shared.isMale != nil {
            SearchViewModel.shared.isMale! ? categoriesId.append(3) : categoriesId.append(4)
        }
        if SearchViewModel.shared.isDrinker != nil {
            SearchViewModel.shared.isDrinker! ? categoriesId.append(5) : categoriesId.append(6)
        }
        if SearchViewModel.shared.isSmoker != nil {
            SearchViewModel.shared.isSmoker! ? categoriesId.append(7) : categoriesId.append(8)
        }
        
        var parameters: [String: Any] = [
            "categoriesId": categoriesId,
            "page": 1
        ]

        if let regionId = SearchViewModel.shared.region?.id {
            parameters["regionId"] = regionId
        }

        if let startDate = SearchViewModel.shared.startDate {
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
            } receiveValue: { [weak self] tripCompanionResponse in
                self?.tripCompanions = tripCompanionResponse.data
//                print(tripCompanionResponse.data)
            }.store(in: &cancellables)
    }
}

extension DomesticCompanionViewModel {
    static let MOCK_VIEW_MODEL: DomesticCompanionViewModel = DomesticCompanionViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
