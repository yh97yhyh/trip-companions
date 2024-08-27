//
//  GenderAndMbtiViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/27/24.
//

import Foundation
import Combine

class GenderAndMbtiViewModel: ObservableObject {
    static let shared = GenderAndMbtiViewModel()
    
    @Published var genders: [Gender]
    @Published var mbtis: [MBTI]
    
    var cancellables = Set<AnyCancellable>()
    
    init(genders: [Gender] = Gender.MOCK_GENDERS, mbtis: [MBTI] = MBTI.MOCK_MBTIS) {
        self.genders = genders
        self.mbtis = mbtis
        getGenderAndMbti()
    }
    
    func getGenderAndMbti() {
        NetworkManager<GenderAndMbti>.request(route: .getGenderAndMbti)
            .sink { _ in
                
            } receiveValue: { [weak self] genderAndMbti in
                self?.genders = genderAndMbti.gender
                self?.mbtis = genderAndMbti.mbti
            }
            .store(in: &cancellables)

    }

}
