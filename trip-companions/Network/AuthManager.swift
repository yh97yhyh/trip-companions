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
    
    func loginWithKakao() -> AnyPublisher<(Bool, Bool), Error> {
        Future { promise in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let oauthToken = oauthToken else {
                    promise(.success((false, false)))
                    return
                }
                
                UserDefaults.standard.set(oauthToken.accessToken, forKey: "kakaoAccessToken")
                self.fetchUserInfo(promise: promise)
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
}
