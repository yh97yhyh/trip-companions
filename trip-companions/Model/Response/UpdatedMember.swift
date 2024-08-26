//
//  UpdatedMember.swift
//  trip-companions
//
//  Created by 영현 on 8/26/24.
//

import Foundation

struct UpdatedMember: Codable, Hashable {
    let nickName: String
    let age: Int
    let gender: String
    let mbti: String
    let isSmoking: Bool?
    let isDrinking: Bool?
}
