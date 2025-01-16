//
//  BlockedUser.swift
//  trip-companions
//
//  Created by 영현 on 1/16/25.
//

import Foundation

struct BlockedUser: Identifiable, Codable, Hashable {
    let id: Int
    let blockMember: Member
}
