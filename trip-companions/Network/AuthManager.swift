//
//  AuthManager.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import Foundation
import Alamofire
import Combine
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var hasUserInfo: Bool? = nil
    @Published var currentMember: Member? = nil
    @Published var token: String? = nil
//    @Published var token: String? = "."
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        let KakaoApiKey = Bundle.main.infoDictionary?["KakaoApiKey"] as! String
        KakaoSDK.initSDK(appKey: KakaoApiKey)
        checkLoginStatus()
    }
    
    // MARK: - Kakao
    func loginWithKakaoTalk() -> AnyPublisher<(Bool, Bool), Error> {
        Future { promise in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("Failed to login with kakaotalk.. \(error.localizedDescription)")
                    promise(.failure(error))
                    return
                }
                
                guard let oauthToken = oauthToken else {
                    print("Failed to get oauthToken..")
                    promise(.success((false, false)))
                    return
                }
                
                self.fetchUserInfo { result in
                    switch result {
                    case .success(let user):
                        let id = String(user.id!)
                        self.signIn(oauthToken.accessToken, id) { success in
                            if success, let token = self.token {
                                let userInfo = UserInfo(kakaoSocialId: id, kakaoAccessToken: oauthToken.accessToken, token: token)
                                self.saveUserToUserDefaults(userInfo)
                                self.isLoggedIn = true
                                promise(.success((true, true)))
                            } else {
                                promise(.success((false, false)))
                            }
                        }
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
                    print("Failed to login with kakaoaccount.. \(error.localizedDescription)")
                    promise(.failure(error))
                    return
                }
                
                guard let oauthToken = oauthToken else {
                    promise(.success((false, false)))
                    return
                }
                
                self.fetchUserInfo { result in
                    switch result {
                    case .success(let user):
                        let id = String(user.id!)
                        self.signIn(oauthToken.accessToken, id) { success in
                            if success, let token = self.token {
                                let userInfo = UserInfo(kakaoSocialId: id, kakaoAccessToken: oauthToken.accessToken, token: token)
                                self.saveUserToUserDefaults(userInfo)
                                self.getMemberInfo(token) { success in
                                    if let curMember = self.currentMember {
                                        InfoCollectionViewModel.shared.age = String(curMember.age)
                                        InfoCollectionViewModel.shared.gender = curMember.gender ?? Gender.MOCK_GENDERS[0]
                                        self.isLoggedIn = true
                                    }
                                }
                                promise(.success((true, true)))
                            } else {
                                promise(.success((false, false)))
                            }
                        }
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
                print("Failed to logout.. \(error)")
            } else {
                UserDefaults.standard.removeObject(forKey: "loggedInUser")
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
            
            completion(.success(user))
        }
    }
    
    private func checkLoginStatus() {
        if let userInfo = loadUserFromUserDefaults() {
            self.fetchUserInfo { result in
                switch result {
                case .success(let user):
                    let id = String(user.id!)
                    self.signIn(userInfo.kakaoAccessToken, id) { success in
                        if success, let token = self.token {
                            let userInfo = UserInfo(kakaoSocialId: id, kakaoAccessToken: userInfo.kakaoAccessToken, token: token)
                            self.saveUserToUserDefaults(userInfo)
                            self.getMemberInfo(token) { success in
                                if let curMember = self.currentMember {
                                    InfoCollectionViewModel.shared.age = String(curMember.age)
                                    InfoCollectionViewModel.shared.gender = curMember.gender ?? Gender.MOCK_GENDERS[0]
                                    self.isLoggedIn = true
                                    print("Succeed to sign-in! \(userInfo)")
                                }
                            }
                           
                        }
                    }
                case .failure(_):
                    print("Failed to sign-in..")
                }
            }
        } else {
            self.isLoggedIn = false
        }
    }
    
    private func renewToken() {
        AuthApi.shared.refreshToken(completion: {_,_ in })
    }
    
    // MARK: - Server
    private func signIn(_ kakaoToken: String, _ id: String, completion: @escaping (Bool) -> Void) {
        let parameters: Parameters = [
            "kakaoAccessToken": kakaoToken,
            "kakaoSocialId": id
        ]
        
        NetworkManager<TokenInfo>.request(route: .postSignIn(parameters))
            .sink { completionStatus in
                switch completionStatus {
                case .finished:
                    print("Succeed to request sign-in!")
                    completion(true)
                case .failure(let error):
                    print("Failed to request sign-in.. \(error.localizedDescription)")
                    completion(false)
                }
            } receiveValue: { tokenInfo in
                self.token = tokenInfo.token
            }.store(in: &cancellables)
    }
    
    func getMemberInfo(_ token: String, completion: @escaping (Bool) -> Void) {
        NetworkManager<Member>.request(route: .getMemberProfile)
            .sink { completionStatus in
                switch completionStatus {
                case .finished:
                    print("Succeed to request member info!")
                    completion(true)
                case .failure(let error):
                    print("Failed to request member info.. \(error.localizedDescription)")
                    completion(false)
                }
            } receiveValue: { member in
                self.currentMember = member
            }.store(in: &cancellables)
    }
    
    // MARK: - UserDefaults
    private func saveUserToUserDefaults(_ user: UserInfo) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "loggedInUser")
        }
    }
    
    func loadUserFromUserDefaults() -> UserInfo? {
        if let savedUserData = UserDefaults.standard.object(forKey: "loggedInUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserInfo.self, from: savedUserData) {
                return loadedUser
            }
        }
        return nil
    }
}

struct UserInfo: Codable {
    let kakaoSocialId: String
    let kakaoAccessToken: String
    let token: String
}
