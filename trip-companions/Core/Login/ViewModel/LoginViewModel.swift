//
//  LoginViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Combine
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        if UserApi.isKakaoTalkLoginAvailable() {
            AuthManager.shared.loginWithKakaoTalk()
                .receive(on: DispatchQueue.main) // UI Update?
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("로그인 실패: \(error)")
                    }
                } receiveValue: { [weak self] success, isNewUser in
//                    self?.isLoggedIn = success
//                    self?.isNewUser = isNewUser
                }.store(in: &cancellables)
        } else {
            AuthManager.shared.loginWithKakaoAccount()
                .receive(on: DispatchQueue.main) // UI Update?
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("로그인 실패: \(error)")
                    }
                } receiveValue: { [weak self] success, isNewUser in
//                    self?.isLoggedIn = success
//                    self?.isNewUser = isNewUser
                }.store(in: &cancellables)
        }
    }    
    
}

extension LoginViewModel {
    static let MOCK_VIEW_MODEL = LoginViewModel()
}
