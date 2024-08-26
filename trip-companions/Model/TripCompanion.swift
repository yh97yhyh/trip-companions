//
//  TripCompanionsWithRegionAndMember.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

struct TripCompanion: Identifiable, Codable, Hashable {
    let id: Int64
//    let tripCompanionsStatus: EnumPresenter
//    let transport: EnumPresenter
//    let tripCompanionsOption: EnumPresenter
    let title: String // temp
    let contents: String
    let companionMemberCount: Int
    let startDate: Date
    let endDate: Date // temp
    let region: Region
    let member: Member
}

extension TripCompanion {
    static let MOCK_TRIP_COMPANION1: TripCompanion = .init(id: 0, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[1], member: Member.MOCK_MEMBER1)
    static let MOCK_TRIP_COMPANION2: TripCompanion = .init(id: 1, title: "제주도에서 동행하실 분", contents: "오늘 제주도에서 바다 보면서 산책하실 분 구합니다!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[2], member: Member.MOCK_MEMBER1)
    static let MOCK_TRIP_COMPANION3: TripCompanion = .init(id: 2, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[1], member: Member.MOCK_MEMBER1)
    static let MOCK_TRIP_COMPANION4: TripCompanion = .init(id: 3, title: "제주도에서 동행하실 분", contents: "오늘 제주도에서 바다 보면서 산책하실 분 구합니다!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[2], member: Member.MOCK_MEMBER1)
    static let MOCK_TRIP_COMPANION5: TripCompanion = .init(id: 4, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[1], member: Member.MOCK_MEMBER1)
    static let MOCK_TRIP_COMPANION6: TripCompanion = .init(id: 5, title: "제주도에서 동행하실 분", contents: "오늘 제주도에서 바다 보면서 산책하실 분 구합니다!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[2], member: Member.MOCK_MEMBER1)
    
    static let MOCK_TRIP_COMPANIONS: [TripCompanion] = [
        MOCK_TRIP_COMPANION1,
        MOCK_TRIP_COMPANION2,
        MOCK_TRIP_COMPANION3,
        MOCK_TRIP_COMPANION4,
        MOCK_TRIP_COMPANION5,
        MOCK_TRIP_COMPANION6,
    ]
}
