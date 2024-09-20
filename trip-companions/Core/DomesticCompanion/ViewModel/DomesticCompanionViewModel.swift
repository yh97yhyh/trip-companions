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

    var page = 1
    var totalPage = 1
    @Published var isFetching = false
    
    var cancellables = Set<AnyCancellable>()
    
    init(tripCompanions: [TripCompanion] = []) {
        self.tripCompanions = tripCompanions
        fetchTripCompanions()
    }
    
    func fetchTripCompanions() {
        if isFetching { return }
        
        page = 1
        tripCompanions.removeAll()
        fetchData()
    }
    
    func addTripCompanions() {
        if page >= totalPage || isFetching { return }
        
        page += 1
        fetchData()
    }

    private func fetchData() {
        isFetching = true

        let parameters = createParameters()
        
        NetworkManager<TripCompanionResponse>.request(route: .getTripCompanions(parameters))
            .sink { completion in
                self.isFetching = false
                switch completion {
                case .finished:
                    print("Succeed to request fetchTripCompanions page:\(self.page)!")
                case .failure(let error):
                    print("Failed to request fetchTripCompanions page:\(self.page).. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] tripCompanionResponse in
                if self?.page == 1 {
                    self?.tripCompanions = tripCompanionResponse.data
                } else {
                    self?.tripCompanions.append(contentsOf: tripCompanionResponse.data)
                }
                self?.totalPage = tripCompanionResponse.totalPage
            }.store(in: &cancellables)
    }
    
    private func createParameters() -> [String: Any] {
        var categoriesId: [Int] = []
        
        if let isSameMbti = SearchViewModel.shared.isSameMbti {
            categoriesId.append(isSameMbti ? 1 : 2)
        }
        if let isMale = SearchViewModel.shared.isMale {
            categoriesId.append(isMale ? 3 : 4)
        }
        if let isDrinker = SearchViewModel.shared.isDrinker {
            categoriesId.append(isDrinker ? 5 : 6)
        }
        if let isSmoker = SearchViewModel.shared.isSmoker {
            categoriesId.append(isSmoker ? 7 : 8)
        }
        
        var parameters: [String: Any] = [
            "categoriesId": categoriesId,
            "page": page
        ]
        
        if let regionId = SearchViewModel.shared.region?.id {
            parameters["regionId"] = regionId
        }
        
        if let startDate = SearchViewModel.shared.startDate {
            parameters["tripDate"] = startDate.toServerDateText()
        }
        
        return parameters
    }
}

extension DomesticCompanionViewModel {
    static let MOCK_VIEW_MODEL: DomesticCompanionViewModel = DomesticCompanionViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
