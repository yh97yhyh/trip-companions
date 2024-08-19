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

class AuthManager {
    static let shared = AuthManager()
    
    init() {
        let KakaoApiKey = Bundle.main.infoDictionary?["KakaoApiKey"] as! String
        KakaoSDK.initSDK(appKey: KakaoApiKey)
        renewToken()
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
                    case .success(let (isLoggedIn, isNewUser)):
                        if isNewUser {
                            print("Succeed to etch user Info - New User!")
                        } else {
                            print("Succeed to etch user Info!")
                        }
                        promise(.success((isLoggedIn, isNewUser)))
                    case .failure(let error):
                        print("Failed to fetch user info : \(error.localizedDescription)")
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
                    case .success(let (isLoggedIn, isNewUser)):
                        if isNewUser {
                            print("Succeed to etch user Info - New User!")
                        } else {
                            print("Succeed to etch user Info!")
                        }
                        promise(.success((isLoggedIn, isNewUser)))
                    case .failure(let error):
                        print("Failed to fetch user info : \(error.localizedDescription)")
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
                print("failed to logout! \(error)")
            } else {
                UserDefaults.standard.removeObject(forKey: "kakaoAccessToken")
                print("succeed to login!")
            }
        }
    }
    
    private func fetchUserInfo(promise: @escaping (Result<(Bool, Bool), Error>) -> Void) {
        UserApi.shared.me { (user, error) in
            if let error = error {
                promise(.failure(error))
                return
            }
            
            if let user = user {
                let isNewUser = user.kakaoAccount?.email == nil
                promise(.success((true, isNewUser)))
            }
        }
    }
    
    func renewToken() {
        AuthApi.shared.refreshToken(completion: {_,_ in })
    }
}
