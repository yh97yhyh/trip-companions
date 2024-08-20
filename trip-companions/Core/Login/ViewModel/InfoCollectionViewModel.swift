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
    
    func updateMemberProfile(_ memberId: Int64, _ loginId: String, _ token: String) {
        let authorization = AuthorizationDetails(memberId: memberId, loginId: loginId)

        let parameters: Parameters = [
            "nickName": nickname,
            "age": age,
            "gender": gender.rawValue,
            "mbti": mbti.rawValue,
            "isSmoking": isSmoking != nil ? isSmoking : nil,
            "isDrinking": isDrinking != nil ? isDrinking : nil
        ]
        
        NetworkManager<Member>.request(route: .updateMemberProfile(parameters, authorization: authorization, toekn: token))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request updateMemberProfile!")
                case .failure(let error):
                    print("Failed to request updateMemberProfile.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] member in
                print("Succeed to update member profile! : \(member)")
                self?.clear()
            }.store(in: &cancellables)
        
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
