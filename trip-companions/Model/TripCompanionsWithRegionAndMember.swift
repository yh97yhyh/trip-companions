//
//  TripCompanionsWithRegionAndMember.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

struct TripCompanionsWithRegionAndMember: Identifiable, Codable, Hashable {
    let id: Int64
//    let tripCompanionsStatus: EnumPresenter
//    let transport: EnumPresenter
//    let tripCompanionsOption: EnumPresenter
    let title: String
    let contents: String
    let companionMemberCount: Int
    let startDate: Date
    let endDate: Date // test
    let region: Region
    let member: [Member]
}

extension TripCompanionsWithRegionAndMember {
    static let MOCK_TRIP_COMPANIONS: [TripCompanionsWithRegionAndMember] = [
        .init(id: 0, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
        .init(id: 1, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
        .init(id: 2, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
        .init(id: 3, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
        .init(id: 3, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
        .init(id: 3, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
        .init(id: 3, title: "오늘 부산 앞바다 야경", contents: "오늘 광안리에서 만나실 분!", companionMemberCount: 1, startDate: Date(), endDate: Date(), region: Region.MOCK_REGIONS[0], member: [Member.MOCK_MEMBER1]),
    ]
}
