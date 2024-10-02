//
//  TripCompanionDetailViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation
import Alamofire
import Combine


class TripCompanionDetailViewModel: ObservableObject {
    @Published var tripCompanion: TripCompanion
    
    var cancellables = Set<AnyCancellable>()

    init(tripCompanion: TripCompanion) {
        self.tripCompanion = tripCompanion
    }
    
    func toTextIsDrinking(_ isDrinking: Bool) -> String {
        return isDrinking ? "음주" : "논알콜"
    }
    
    func toTextIsSmoking(_ isSmoking: Bool) -> String {
        return isSmoking ? "흡연" : "비흡연"
    }
    
    func reportTripCompanion(_ reportType: String) {
        let parameters: Parameters = [
            "reportType" : reportType
        ]
        
        NetworkManager<Int>.requestWithoutResponse(route: .reportTripCompanion(postId: tripCompanion.id, parameters))
            .sink {  completion in
                switch completion {
                case .finished:
                    print("Succeed to reportTripCompanion \(self.tripCompanion.id)!")
                case .failure(let error):
                    print("Failed to reportTripCompanion.. \(error.localizedDescription)")
                }
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
    
    func blockUser() {
        let parameters: Parameters = [
            "blockMemberId" : "\(tripCompanion.member.id)"
        ]
        
        NetworkManager<Int>.requestWithoutResponse(route: .blockUser(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to blockUser \(self.tripCompanion.member.id)!")
                case .failure(let error):
                    print("Failed to withdraw.. \(error.localizedDescription)")
                }
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
}

extension TripCompanionDetailViewModel{
    static let MOCK_VIEW_MODEL = TripCompanionDetailViewModel(tripCompanion: TripCompanion.MOCK_TRIP_COMPANION2)
}
