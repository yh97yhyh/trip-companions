//
//  InfoCollectionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Combine

class InfoCollectionViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var age: String = ""
    @Published var gender: Gender? = nil
    @Published var mbti: MBTI? = nil
    @Published var isSmoker: Bool? = nil
    @Published var isDrinker: Bool? = nil
    
    @Published private(set) var isFormValid: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest6($nickname, $age, $gender, $mbti, $isSmoker, $isDrinker)
            .map { nickname, age, gender, mbti, isSmoker, isDrinker in
                return !nickname.isEmpty &&
                       !age.isEmpty &&
                       gender != nil &&
                       mbti != nil &&
                       isSmoker != nil &&
                       isDrinker != nil
            }
            .assign(to: &$isFormValid)
    }
}

enum Gender: String, CaseIterable, Identifiable {
    case male = "남성"
    case female = "여성"
    
    var id: String { rawValue }
}

enum MBTI: String, CaseIterable, Identifiable {
    case intj = "INTJ"
    case intp = "INTP"
    case entj = "ENTJ"
    case entp = "ENTP"
    case infj = "INFJ"
    case infp = "INFP"
    case enfj = "ENFJ"
    case enfp = "ENFP"
    case istj = "ISTJ"
    case isfj = "ISFJ"
    case estj = "ESTJ"
    case esfj = "ESFJ"
    case istp = "ISTP"
    case isfp = "ISFP"
    case estp = "ESTP"
    case esfp = "ESFP"
    
    var id: String { rawValue }
}
