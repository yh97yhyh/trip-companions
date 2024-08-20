//
//  InfoCollectionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Combine
import Alamofire

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
    @Published var isSmoking: Bool? = nil {
        didSet {
            validateForm()
        }
    }
    @Published var isDrinking: Bool? = nil {
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
    }

    private var cancellables = Set<AnyCancellable>()

    init() {
        
    }
    
    func updateMemberProfile() {
        let parameters: Parameters = [
            "nickName": nickname,
            "age": age,
            "gender": gender,
            "mbti": mbti,
            "isSmoking": isSmoking != nil ? isSmoking : nil,
            "isDrinking": isDrinking != nil ? isDrinking : nil
        ]
        
        NetworkManager<Member>.request(route: .updateMemberProfile(parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] member in
                print("Succeed to update member profile!")
            }.store(in: &cancellables)
        
        clear()
    }
    
    private func clear() {
        nickname = ""
        age = ""
        gender = .male
        mbti = .intj
        isSmoking = nil
        isDrinking = nil
        isComplete = false
        isEditingNickname = false
        isEditingAge = false
    }
}
