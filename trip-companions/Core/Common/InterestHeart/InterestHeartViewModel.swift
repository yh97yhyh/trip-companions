//
//  InterestHeartViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/21/24.
//

import Foundation
import Alamofire
import Combine

class InterestHeartViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
    @Published var isUpdateHeartLike: Bool
    @Published var updateHeartCount: Int
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
        self.isUpdateHeartLike = tripCompanion.isInterestTripCompanion ?? false
        self.updateHeartCount = tripCompanion.interestTripCompanionCount
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func toggleLike(writer: Member, isLike: Bool) {
        if isLike {
            like()
        } else {
            unlike()
        }
    }
    
    func like() {
        let parameters: Parameters = [
            "tripCompanionId" : tripCompanion.id
        ]
        
        NetworkManager<TripCompanion>.request(route: .createLikeTripCompanion(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request createLikeTripCompanion!")
                case .failure(let error):
                    print("Failed to request createLikeTripCompanion.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] tripCompanion in
                self?.isUpdateHeartLike = true
                self?.updateHeartCount += 1
            }.store(in: &cancellables)
    }
    
    func unlike() {
        NetworkManager<Int>.requestWithoutResponse(route: .deleteLikeTripCompanion(postId: tripCompanion.id))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request deleteLikeTripCompanion!")
                case .failure(let error):
                    print("Failed to request deleteLikeTripCompanion.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] _ in
                self?.isUpdateHeartLike = false
                self?.updateHeartCount -= 1
            }.store(in: &cancellables)
    }
    
}

extension InterestHeartViewModel {
    static let MOCK_VIEW_MODEL = InterestHeartViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])
}
