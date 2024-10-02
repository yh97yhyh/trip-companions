//
//  MyInterestingTripCompanionCellViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import Foundation
import Alamofire
import Combine

class MyInterestingTripCompanionCellViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func deleteLike() {
        NetworkManager<Int>.requestWithoutResponse(route: .deleteLikeTripCompanion(postId: tripCompanion.id))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request deleteLikeTripCompanion!")
                case .failure(let error):
                    print("Failed to request deleteLikeTripCompanion.. \(error.localizedDescription)")
                }
//                MyInterestingPostsViewModel.shared.fetchTripCompanions()
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
}

extension MyInterestingTripCompanionCellViewModel {
    static let MOCK_VIEW_MODEL = MyInterestingTripCompanionCellViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])

}
