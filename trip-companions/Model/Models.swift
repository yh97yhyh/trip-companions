//
//  Models.swift
//  trip-companions
//
//  Created by 영현 on 8/12/24.
//

import Foundation

// MARK: - TripCompanionsCreateRequest
struct TripCompanionsCreateRequest: Codable {
    let regionId: Int64
    let startDate: String
    let companionMemberCount: Int32?
    let startLocation: String?
    let contents: String?
    let categoriesId: [Int64]?
}

//// MARK: - AuthorizationDetails
//struct AuthorizationDetails: Codable {
//    let memberId: Int64
//    let loginId: String
//}

// MARK: - EnumPresenter
struct EnumPresenter: Codable {
    let code: String
    let desc: String
}

// MARK: - PagingResponseTripCompanionsWithRegionAndMember
struct PagingResponseTripCompanionsWithRegionAndMember: Codable {
    let totalElements: Int64
    let totalPage: Int32
    let data: [TripCompanion]
}
