//
//  Member.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation

struct Member: Identifiable, Codable, Hashable {
    let id: Int
    let loginId: String
    let age: Int
    let name: String
    let nickName: String?
    let phoneNumber: String
    let email: String
    var profileImageUrl: String?
    let tokenKey: String
    let mbti: MBTI?
    let gender: Gender?
    let isSmoking: Bool?
    let isDrinking: Bool?
    let isLogin: Bool
    let isDelete: Bool
}

extension Member {
    static let MOCK_MEMBER1: Member = .init(id: 0, loginId: "member1", age: 25, name: "김소피", nickName: "Sophie", phoneNumber: "010-1234-1234", email: "member1@test.com", tokenKey: "test", mbti: MBTI.MOCK_MBTIS[0], gender: Gender.MOCK_GENDERS[0], isSmoking: true, isDrinking: true, isLogin: true, isDelete: false)
}
