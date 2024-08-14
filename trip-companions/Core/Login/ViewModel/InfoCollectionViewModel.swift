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

    @Published var isComplete: Bool = false
    @Published var isEditingNickname = false
    @Published var isEditingAge = false

    private func validateForm() {
        isComplete = !nickname.isEmpty &&
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
