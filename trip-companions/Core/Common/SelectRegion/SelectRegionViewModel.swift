//
//  SelectRegionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/23/24.
//

import Foundation

class SelectRegionViewModel: ObservableObject {
    static let shared = SelectRegionViewModel()
    
    @Published var region: Region? = nil
    
    init(region: Region? = nil) {
        self.region = region
    }
}

