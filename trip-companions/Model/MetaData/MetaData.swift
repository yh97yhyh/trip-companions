//
//  Meta.swift
//  trip-companions
//
//  Created by 영현 on 9/12/24.
//

import Foundation

struct MetaData: Codable, Hashable {
    let categories: [Category]
    let regions: [Region]
    let tripCompanionStatus: [TripCompanionStatus]
    let ageRange: [AgeRange]
    let gender: [Gender]
    let mbti: [MBTI]
}

struct Category: Codable, Hashable {
    let id: Int
    let categoriesType: String
}

extension Category {
    static let MOCK_CATEGORIES: [Category] = [
        .init(id: 1, categoriesType: "같은 MBTI"),
        .init(id: 2, categoriesType: "다른 MBTI도 좋아요"),
        .init(id: 3, categoriesType: "남성"),
        .init(id: 4, categoriesType: "여성"),
        .init(id: 5, categoriesType: "음주"),
        .init(id: 6, categoriesType: "논알콜"),
        .init(id: 7, categoriesType: "흡연"),
        .init(id: 8, categoriesType: "비흡연"),
    ]
}

struct Region: Identifiable, Codable, Hashable {
    let id: Int64
    let regionName: String
}

extension Region {
    static let MOCK_REGIONS: [Region] = [
        .init(id: 1, regionName: "부산시"),
        .init(id: 2, regionName: "서울시"),
        .init(id: 3, regionName: "울산"),
        .init(id: 4, regionName: "대구"),
    ]
}

struct TripCompanionStatus: Codable, Hashable {
    let code: String
    let desc: String
}

extension TripCompanionStatus {
    static let MOCK_TRIP_COMPANION_STATUSES: [TripCompanionStatus] = [
        .init(code: "DISPLAY", desc: "모집중"),
        .init(code: "HIDE", desc: "숨김"),
        .init(code: "COMPLETE", desc: "모집아ㅗㄴ료")
    ]
}

struct AgeRange: Codable, Hashable {
    let code: String
    let desc: String
}

extension AgeRange {
    static let MOCK_AGE_RANGES: [AgeRange] = [
        .init(code: "TEENAGERS", desc: "10대"),
        .init(code: "TWENTIES", desc: "20대"),
        .init(code: "THIRTY", desc: "30대"),

    ]
}

struct Gender: Codable, Hashable {
    let code: String
    let desc: String
}

extension Gender {
    static let MOCK_GENDERS: [Gender] = [
        .init(code: "MALE", desc: "남자"),
        .init(code: "FEMALE", desc: "여자")
    ]
}

struct MBTI: Codable, Hashable {
    let code: String
    let desc: String
}

extension MBTI {
    static let MOCK_MBTIS: [MBTI] = [
//        .init(code: "ETC", desc: "기타"),
        .init(code: "INTP", desc: "INTP"),
        .init(code: "ISTP", desc: "ISTP")
    ]
}

