//
//  TripCompanionResponse.swift
//  trip-companions
//
//  Created by 영현 on 9/12/24.
//

import Foundation

struct TripCompanionResponse: Codable, Hashable {
    let totalElements: Int
    let totalPage: Int
    let data: [TripCompanion]
}
