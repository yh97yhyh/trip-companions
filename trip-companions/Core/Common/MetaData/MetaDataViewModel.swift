//
//  GenderAndMbtiViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/27/24.
//

import Foundation
import Combine

class MetaDataViewModel: ObservableObject {
    static let shared = MetaDataViewModel()
    
    @Published var categories: [Category]
    @Published var regions: [Region]
    @Published var tripCompanionStatuses: [TripCompanionStatus]
    @Published var ageRanges: [AgeRange]
    @Published var genders: [Gender]
    @Published var mbtis: [MBTI]
    
    var cancellables = Set<AnyCancellable>()
    
    init(categories: [Category] = [], regions: [Region] = [], tripCompanionStatuses: [TripCompanionStatus] = [], ageRanges: [AgeRange] = [], genders: [Gender] = [], mbtis: [MBTI] = []) {
        self.categories = categories
        self.regions = regions
        self.tripCompanionStatuses = tripCompanionStatuses
        self.ageRanges = ageRanges
        self.genders = genders
        self.mbtis = mbtis
        getMetaData()
    }
    
    func getMetaData() {
        NetworkManager<MetaData>.request(route: .getMetaData)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request getMetaData!")
                case .failure(let error):
                    print("Failed to request getMetaData.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] metadata in
                self?.categories = metadata.categories
                self?.regions = metadata.regions
                self?.tripCompanionStatuses = metadata.tripCompanionStatus
                self?.ageRanges = metadata.ageRange
                self?.genders = metadata.gender
                self?.mbtis = metadata.mbti
//                self?.mbtis.insert(MBTI(code: "ETC", desc: "선택안함"), at: 0)
            }
            .store(in: &cancellables)

    }

}
