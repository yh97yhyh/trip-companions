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
    
    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func toggleLike(writer: Member, isLike: Bool) {
        if tripCompanion.member == writer {
            return
        }
        
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
            } receiveValue: { tripCompanion in
                self.tripCompanion = tripCompanion
            }
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
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
    
}

extension InterestHeartViewModel {
    static let MOCK_VIEW_MODEL = InterestHeartViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANIONS[0])
}
