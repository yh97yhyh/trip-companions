//
//  ProfileHeaderViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import Foundation

class ProfileHeaderViewModel: ObservableObject {
    @Published var isShowingProfileUpdateButton: Bool = false
    
    init(isShowingProfileUpdateButton: Bool) {
        self.isShowingProfileUpdateButton = isShowingProfileUpdateButton
    }
    
    func toTextIsDrinking(_ isDrinking: Bool) -> String {
        return isDrinking ? "음주" : "논알콜"
    }
    
    func toTextIsSmoking(_ isSmoking: Bool) -> String {
        return isSmoking ? "흡연" : "비흡연"
    }
}

extension ProfileHeaderViewModel {
    static let MOCK_VIEW_MODEL1 = ProfileHeaderViewModel(isShowingProfileUpdateButton: false)
    static let MOCK_VIEW_MODEL2 = ProfileHeaderViewModel(isShowingProfileUpdateButton: true)

}
