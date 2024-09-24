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
    @Published var gender: Gender? = nil {
        didSet {
            validateForm()
        }
    }
    @Published var mbti: MBTI? = nil {
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
        !age.isEmpty &&
        gender != nil
    }

    private var cancellables = Set<AnyCancellable>()
    
    func updateMemberProfile(completion: @escaping (Member) -> Void) {
        var parameters: Parameters = [
            "nickName": nickname,
            "age": Int(age)!,
            "gender": gender!.desc,
            "mbti": mbti?.desc ?? "",
            "isSmoking": isSmoking != nil ? isSmoking! : nil,
            "isDrinking": isDrinking != nil ? isDrinking! : nil
        ]

        // Adding additional parameters based on nil checks
        if mbti == nil {
            parameters["clearMbti"] = true
        }

        if isSmoking == nil {
            parameters["clearIsSmoking"] = true
        }

        if isDrinking == nil {
            parameters["clearIsDrinking"] = true
        }
        
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
