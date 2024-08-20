//
//  Models.swift
//  trip-companions
//
//  Created by 영현 on 8/12/24.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable, Codable, Hashable {
    case male = "남성"
    case female = "여성"
    
    var id: String { rawValue }
    
    func toKey() -> String {
        switch self {
        case .male:
            return "MALE"
        case .female:
            return "FEMALE"
        }
    }
}

enum MBTI: String, CaseIterable, Identifiable, Codable, Hashable {
    case intj = "INTJ"
    case intp = "INTP"
    case entj = "ENTJ"
    case entp = "ENTP"
    case infj = "INFJ"
    case infp = "INFP"
    case enfj = "ENFJ"
    case enfp = "ENFP"
    case istj = "ISTJ"
    case isfj = "ISFJ"
    case estj = "ESTJ"
    case esfj = "ESFJ"
    case istp = "ISTP"
    case isfp = "ISFP"
    case estp = "ESTP"
    case esfp = "ESFP"
    
    var id: String { rawValue }
}


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
