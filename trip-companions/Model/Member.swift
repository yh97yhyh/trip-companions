//
//  Member.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation

struct Member: Identifiable, Codable, Hashable {
    let id: Int64
    let loginId: String
    let name: String
    let age: Int // temp
    let nickName: String
    let phoneNumber: String
    let email: String
    var profileImageUrl: String? = nil
    let tokenKey: String
    let mbti: MBTI
    let gender: Gender
    let isSmoking: Bool
    let isDrinking: Bool // temp
    var drinkingCapacity: Double? = nil
    let login: Bool
    let delete: Bool
}

extension Member {
    static let MOCK_MEMBER1: Member = .init(id: 0, loginId: "member1", name: "김소피", age: 25, nickName: "Sophie", phoneNumber: "010-1234-1234", email: "member1@test.com", tokenKey: "test", mbti: .enfp, gender: .female, isSmoking: true, isDrinking: true, login: true, delete: false)
}
