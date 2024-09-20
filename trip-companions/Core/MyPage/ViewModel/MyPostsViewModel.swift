//
//  MyPostsViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import Foundation
import Alamofire
import Combine

class MyPostsViewModel: ObservableObject {
    static let shared = MyPostsViewModel()

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
        
        NetworkManager<TripCompanionResponse>.request(route: .getMyTripCompanions)
            .sink { completion in
                self.isFetching = false
                switch completion {
                case .finished:
                    print("Succeed to request getMyTripCompanions page:\(self.page)!")
                case .failure(let error):
                    print("Failed to request getMyTripCompanions page:\(self.page).. \(error.localizedDescription)")
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

extension MyPostsViewModel {
    static let MOCK_VIEW_MODEL = MyPostsViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
