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
    let nickName: String
    let phoneNumber: String?
    let email: String?
    let profileImageUrl: String?
    let tokenKey: String?
    let mbti: MBTI
    let gender: Gender
    let isSmoking: Bool
    let drinkingCapacity: Double?
    let login: Bool
    let delete: Bool
}
