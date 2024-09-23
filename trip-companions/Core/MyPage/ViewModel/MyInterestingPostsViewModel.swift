//
//  MyInterestingPostsViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import Foundation
import Alamofire
import Combine

class MyInterestingPostsViewModel: ObservableObject {
    static let shared = MyInterestingPostsViewModel()
    
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
        
        let parameters: [String: Any] = [
            "page": page,
            "size": 20
        ]
        
        NetworkManager<TripCompanionResponse>.request(route: .getMyLikeTripCompanions(parameters))
            .sink { completion in
                self.isFetching = false
                switch completion {
                case .finished:
                    print("Succeed to request getMyLikeTripCompanions page:\(self.page)!")
                case .failure(let error):
                    print("Failed to request getMyLikeTripCompanions page:\(self.page).. \(error.localizedDescription)")
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

}

extension MyInterestingPostsViewModel {
    static let MOCK_VIEW_MODEL = MyInterestingPostsViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)

}
