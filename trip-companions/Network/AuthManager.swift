//
//  AuthManager.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Combine
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentMember: Member? = nil
    @Published var memberId: Int64? = nil
    @Published var loginId: String? = nil
    @Published var token: String? = nil
    
    static let shared = AuthManager()
    
    init() {
        let KakaoApiKey = Bundle.main.infoDictionary?["KakaoApiKey"] as! String
        KakaoSDK.initSDK(appKey: KakaoApiKey)
        //        renewToken()
        checkLoginStatus()
    }
    
    func loginWithKakaoTalk() -> AnyPublisher<(Bool, Bool), Error> {
        Future { promise in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("Failed to login with kakaotalk : \(error.localizedDescription)")
                    promise(.failure(error))
                    return
                }
                
                guard let oauthToken = oauthToken else {
                    promise(.success((false, false)))
                    return
                }
                
                UserDefaults.standard.set(oauthToken.accessToken, forKey: "kakaoAccessToken")
                
                self.fetchUserInfo { result in
                    switch result {
                    case .success(let user):
                        self.isLoggedIn = true
                        self.memberId = user.id
                        self.loginId = user.email
                        self.token = oauthToken.accessToken
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func loginWithKakaoAccount() -> AnyPublisher<(Bool, Bool), Error> {
        Future { promise in
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("Failed to login with kakaoaccount : \(error.localizedDescription)")
                    promise(.failure(error))
                    return
                }
                
                guard let oauthToken = oauthToken else {
                    promise(.success((false, false)))
                    return
                }
                
                UserDefaults.standard.set(oauthToken.accessToken, forKey: "kakaoAccessToken")
                
                self.fetchUserInfo { result in
                    switch result {
                    case .success(let user):
                        self.isLoggedIn = true
                        self.memberId = user.id
                        self.loginId = user.email
                        self.token = oauthToken.accessToken
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        UserApi.shared.logout { error in
            if let error = error {
                print("Failed to logout! \(error)")
            } else {
                UserDefaults.standard.removeObject(forKey: "kakaoAccessToken")
                print("Succeed to logout!")
            }
        }
    }
    
    func fetchUserInfo(completion: @escaping (Result<User, Error>) -> Void) {
        UserApi.shared.me { user, error in
            if let error = error {
                print("Failed to fetch user info: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let user = user else {
                completion(.failure(NSError(domain: "AuthManagerError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User information not found"])))
                return
            }
            
            let user1 = User(id: user.id!, email: user.kakaoAccount?.email ?? "No email")
            completion(.success(user1))
        }
    }
    
    private func saveUser() {
        isLoggedIn = true
    }
    
    private func checkLoginStatus() {
        if let token = UserDefaults.standard.string(forKey: "kakaoAccessToken") {
            self.isLoggedIn = true
            fetchUserInfo { result in
                switch result {
                case .success(let user):
                    self.memberId = user.id
                    self.loginId = user.email
                    self.token = token
                case .failure(let error):
                    print("Failed to fetch user info after login check: \(error.localizedDescription)")
                    self.isLoggedIn = false
                }
            }
        } else {
            self.isLoggedIn = false
        }
    }
    
    private func renewToken() {
        AuthApi.shared.refreshToken(completion: {_,_ in })
    }
}

struct User {
    let id: Int64
    let email : String
}
