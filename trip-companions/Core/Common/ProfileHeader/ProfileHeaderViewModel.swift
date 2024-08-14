//
//  ProfileHeaderViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class ProfileHeaderViewModel: ObservableObject {
    @Published var member: Member
    @Published var isShowingProfileUpdateButton: Bool = false
    
    init(member: Member, isShowingProfileUpdateButton: Bool) {
        self.member = member
        self.isShowingProfileUpdateButton = isShowingProfileUpdateButton
    }
    
    func toTextIsDrinking() -> String {
        return member.isDrinking ? "음주" : "논알콜"
    }
    
    func toTextIsSmoking() -> String {
        return member.isSmoking ? "흡연" : "비흡연"
    }
}

extension ProfileHeaderViewModel {
    static let MOCK_VIEW_MODEL1 = ProfileHeaderViewModel(member: Member.MOCK_MEMBER1, isShowingProfileUpdateButton: false)
    static let MOCK_VIEW_MODEL2 = ProfileHeaderViewModel(member: Member.MOCK_MEMBER1, isShowingProfileUpdateButton: true)

}
