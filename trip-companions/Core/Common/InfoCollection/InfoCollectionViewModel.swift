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
    @Published var gender: Gender = Gender.MOCK_GENDERS[0] {
        didSet {
            validateForm()
        }
    }
    @Published var mbti: MBTI = MBTI.MOCK_MBTIS[0]  {
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
    
    func updateMemberProfile(completion: @escaping (Member) -> Void) {
        let parameters: Parameters = [
            "nickName": nickname,
            "age": Int(age)!,
            "gender": gender.desc,
            "mbti": mbti.desc,
            "isSmoking": isSmoking != nil ? isSmoking : nil,
            "isDrinking": isDrinking != nil ? isDrinking : nil
        ]
        
        NetworkManager<Member>.request(route: .updateMemberProfile(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request updateMemberProfile!")
                case .failure(let error):
                    print("Failed to request updateMemberProfile.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] member in
                print("Succeed to update member profile! : \(member)")
                completion(member)
            }.store(in: &cancellables)
        
    }
    
}
