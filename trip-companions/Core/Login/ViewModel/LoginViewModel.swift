//
//  LoginViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isNewUser: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        checkLoginStatus()
    }
    
    private func checkLoginStatus() {
        if let _ = UserDefaults.standard.string(forKey: "kakaoAccessToken") {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
    
    func login() {
        AuthManager.shared.loginWithKakao()
            .receive(on: DispatchQueue.main) // UI Update?
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("로그인 실패: \(error)")
                }
            } receiveValue: { [weak self] success, isNewUser in
                self?.isLoggedIn = success
                self?.isNewUser = isNewUser
            }.store(in: &cancellables)
    }
    
    func logout() {
        AuthManager.shared.logout()
        
        self.isLoggedIn = false
        self.isNewUser = false
    }
    
}
