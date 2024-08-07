//
//  InfoCollectionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Combine

class InfoCollectionViewModel: ObservableObject {
    static let shared = InfoCollectionViewModel()
    
    @Published var nickname: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var age: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var gender: Gender = .male {
        didSet {
            validateForm()
        }
    }
    @Published var mbti: MBTI = .intj {
        didSet {
            validateForm()
        }
    }
    @Published var isSmoker: Bool? = nil {
        didSet {
            validateForm()
        }
    }
    @Published var isDrinker: Bool? = nil {
        didSet {
            validateForm()
        }
    }

    @Published var isFromValid: Bool = false

    private func validateForm() {
        isFromValid = !nickname.isEmpty &&
                      !age.isEmpty
//                      gender != nil &&
//                      mbti != nil
//                      isSmoker != nil &&
//                      isDrinker != nil
    }

    private var cancellables = Set<AnyCancellable>()

    init() {
        
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
