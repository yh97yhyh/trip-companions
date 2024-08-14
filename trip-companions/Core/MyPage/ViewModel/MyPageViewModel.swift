//
//  MyPageViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation
import Alamofire
import Combine

class MyPageViewModel: ObservableObject {
    @Published var member: Member
    
    init(member: Member) {
        self.member = member
    }
}

extension MyPageViewModel {
    static let MOCK_VIEW_MODEL = MyPageViewModel(member: Member.MOCK_MEMBER1)
}
