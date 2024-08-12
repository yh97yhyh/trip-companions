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

// MARK: - AuthorizationDetails
struct AuthorizationDetails: Codable {
    let memberId: Int64
    let loginId: String
}

// MARK: - EnumPresenter
struct EnumPresenter: Codable {
    let code: String
    let desc: String
}

// MARK: - Members
struct Members: Codable {
    let id: Int64
    let loginId: String
    let name: String
    let nickName: String
    let phoneNumber: String?
    let email: String?
    let profileImageUrl: String?
    let tokenKey: String?
    let mbti: EnumPresenter
    let gender: EnumPresenter
    let isSmoking: Bool
    let drinkingCapacity: Double?
    let login: Bool
    let delete: Bool
}

// MARK: - Regions
struct Regions: Codable {
    let id: Int64
    let regionName: String
}

// MARK: - TripCompanionsWithRegionAndMember
struct TripCompanionsWithRegionAndMember: Codable {
    let id: Int64
    let tripCompanionsStatus: EnumPresenter
    let transport: EnumPresenter
    let tripCompanionsOption: EnumPresenter
    let contents: String
    let companionMemberCount: Int32
    let startDate: String
    let region: Regions
    let member: Members
}

// MARK: - MemberInterestsCreateOrUpdateRequest
struct MemberInterestsCreateOrUpdateRequest: Codable {
    let nickName: String
    let age: Int32
    let gender: String // "MALE" or "FEMALE" enum 값으로 처리 가능
    let mbti: String // "INTP", "ISTP" 등
    let isSmoking: Bool
    let drinkingCapacity: Double
}

// MARK: - PagingResponseTripCompanionsWithRegionAndMember
struct PagingResponseTripCompanionsWithRegionAndMember: Codable {
    let totalElements: Int64
    let totalPage: Int32
    let data: [TripCompanionsWithRegionAndMember]
}
