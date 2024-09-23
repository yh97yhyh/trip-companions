//
//  HomeViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation
import Combine
import Alamofire

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    
    @Published var tripCompanions: [TripCompanion] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(tripCompanions: [TripCompanion] = []) {
        self.tripCompanions = tripCompanions
        
        fetchRecommendedTripCompanions()
    }
    
    func fetchRecommendedTripCompanions() {
        var parameters = Parameters()
        if AuthManager.shared.isLoggedIn {
            parameters = [
                "regionId": AuthManager.shared.currentMember?.interestRegion?.id ?? nil,
                "memberId": AuthManager.shared.currentMember!.id
            ]
        }
        
        NetworkManager<[TripCompanion]>.request(route: .getRecommendedTripCompanions(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request getRecommendedTripCompanions!")
                case .failure(let error):
                    print("Failed to request getRecommendedTripCompanions.. \(error.localizedDescription)")
                }
            } receiveValue: { tripCompanions in
                self.tripCompanions = tripCompanions
            }.store(in: &cancellables)
    }
}

extension HomeViewModel {
    static let MOCK_VIEW_MODEL: HomeViewModel = HomeViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
