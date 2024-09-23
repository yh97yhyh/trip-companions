//
//  SelectRegionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/23/24.
//

import Foundation
import Alamofire
import Combine

class SelectRegionViewModel: ObservableObject {
    static let shared = SelectRegionViewModel()
    
    @Published var region: Region? = nil
    @Published var regionKeyword = "" {
        didSet {
            filterRegions()
        }
    }
    @Published var filteredRegions = MetaDataViewModel.shared.regions
    
    private var cancellables = Set<AnyCancellable>()
    
    init(region: Region? = nil) {
        self.region = region
    }
    
    func filterRegions() {
        if regionKeyword.isEmpty {
            filteredRegions = MetaDataViewModel.shared.regions
        } else {
            filteredRegions = MetaDataViewModel.shared.regions.filter { region in
                return region.regionName.lowercased().contains(regionKeyword.lowercased())
            }
        }
    }
    
    func updateInterestRegion(completion: @escaping (Member) -> Void) {
        let parameters: Parameters = [
            "regionId": region?.id ?? nil
        ]
        
        NetworkManager<Member>.request(route: .updateInterestRegion(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request updateInterestRegion!")
                case .failure(let error):
                    print("Failed to request updateInterestRegion.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] member in
                print("Succeed to update interest Region! : \(member.interestRegion)")
                completion(member)
            }.store(in: &cancellables)
        
    }
}

