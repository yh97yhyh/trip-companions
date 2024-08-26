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
    let age: Int
    let name: String
    let nickName: String
    let phoneNumber: String
    let email: String
    var profileImageUrl: String?
    let tokenKey: String
    let mbti: MBTI
    let gender: Gender
    let isSmoking: Bool?
    let isDrinking: Bool?
    let login: Bool
    let delete: Bool
}

//struct MemberSimple: Identifiable, Codable, Hashable {
//    let id: Int
//    let email: String
//    let nickName: String
//    let age: Int
//    let gender: String
//    let mbti: String
//    let isSmoking: Bool?
//    let isDrinking: Bool?
//}

extension Member {
    static let MOCK_MEMBER1: Member = .init(id: 0, loginId: "member1", age: 25, name: "김소피", nickName: "Sophie", phoneNumber: "010-1234-1234", email: "member1@test.com", tokenKey: "test", mbti: .enfp, gender: .female, isSmoking: true, isDrinking: true, login: true, delete: false)
}
