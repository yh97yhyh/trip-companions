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
        
        NetworkManager<TripCompanionResponse>.request(route: .getMyTripCompanions(parameters))
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
                print("myPostsCount : \(self!.tripCompanions.count)")
                self?.totalPage = tripCompanionResponse.totalPage
            }.store(in: &cancellables)
    }
    
    func deletePost(postId: Int) {
        NetworkManager<Int>.requestWithoutResponse(route: .deleteTripCompanion(postId: postId))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request deleteTripCompanion!")
                case .failure(let error):
                    print("Failed to request deleteTripCompanion.. \(error.localizedDescription)")
                }
                MyPostsViewModel.shared.fetchTripCompanions()
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
    
}

extension MyPostsViewModel {
    static let MOCK_VIEW_MODEL = MyPostsViewModel(tripCompanions: TripCompanion.MOCK_TRIP_COMPANIONS)
}
