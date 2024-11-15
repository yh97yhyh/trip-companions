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
import AuthenticationServices

class AuthManager: NSObject, ObservableObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    static let shared = AuthManager()

    @Published var isGuestMode: Bool = false {
        didSet {
            if self.isGuestMode == true {
                isLoggedIn = false
            }
        }
    }
    @Published var isLoggedIn: Bool = false {
        didSet {
            if self.isLoggedIn == true {
                isGuestMode = false
            }
        }
    }
    @Published var hasUserInfo: Bool? = nil
    @Published var currentMember: Member? = nil
    @Published var token: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
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
                                let userInfo = UserInfo(userId: id, socialToken: oauthToken.accessToken, token: token, socialType: .kakao)
                                self.saveUserToUserDefaults(userInfo)
                                self.getMemberInfo(token) { success in
                                    if let curMember = self.currentMember {
                                        InfoCollectionViewModel.shared.age = curMember.age.map { String($0) } ?? ""
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
                                let userInfo = UserInfo(userId: id, socialToken: oauthToken.accessToken, token: token, socialType: .kakao)
                                self.saveUserToUserDefaults(userInfo)
                                self.getMemberInfo(token) { success in
                                    if let curMember = self.currentMember {
                                        InfoCollectionViewModel.shared.age = curMember.age.map { String($0) } ?? ""
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
    
    func renewToken() {
        AuthApi.shared.refreshToken(completion: {_,_ in })
    }
    
    func unlinkKakao() {
        UserApi.shared.unlink { error in
            if let error = error {
                print("Failed to unlik kakao.. \(error)")
            } else {
                print("Succeed to unlik kakao!")
            }
        }
    }
    
    // MARK: - Apple
    func loginWithApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let authorizationCodeData = appleIDCredential.authorizationCode,
                  let authorizationCode = String(data: authorizationCodeData, encoding: .utf8),
                  let identifyTokenData = appleIDCredential.identityToken,
                  let identifyToken = String(data: identifyTokenData, encoding: .utf8) else {
                print("Failed to retrieve authorization code.")
                return
            }
            
            let fullName = appleIDCredential.fullName
            let givenName = fullName?.givenName ?? ""
            let familyName = fullName?.familyName ?? ""
            let name = "\(familyName)\(givenName)"
            let email = appleIDCredential.email ?? ""
            
            let userID = appleIDCredential.user
            signInApple(authorizationCode, userID, name) { success in
                if success, let token = self.token {
                    let userInfo = UserInfo(userId: userID, socialToken: authorizationCode, token: token, socialType: .apple)
                    self.saveUserToUserDefaults(userInfo)
                    self.getMemberInfo(token) { success in
                        if let curMember = self.currentMember {
                            InfoCollectionViewModel.shared.age = curMember.age.map { String($0) } ?? ""
                            InfoCollectionViewModel.shared.gender = curMember.gender ?? Gender.MOCK_GENDERS[0]
                            self.isLoggedIn = true
                        }
                    }
                    print("Succeed to sign-in with apple!")
                } else {
                    print("Failed to sign-in with apple!")
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed to login with apple.. \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
    
    func unlilnkApple() {
        
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
    
    private func signInApple(_ appleAuthCode: String, _ id: String, _ name: String, completion: @escaping (Bool) -> Void) {
        let parameters: Parameters = [
            "appleAuthCode": appleAuthCode,
            "name": name
        ]
        
        NetworkManager<TokenInfo>.request(route: .postSignInAppleWithApple(parameters))
            .sink { completionStatus in
                switch completionStatus {
                case .finished:
                    print("Succeed to request sign-in with apple!")
                    completion(true)
                case .failure(let error):
                    print("Failed to request sign-in with apple.. \(error.localizedDescription)")
                    completion(false)
                }
            } receiveValue: { tokenInfo in
                self.token = tokenInfo.token
            }.store(in: &cancellables)
    }
    
    func withDraw() {
        NetworkManager<Int>.requestWithoutResponse(route: .withDraw)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to withdraw!")
                    break
                case .failure(let error):
                    print("Failed to withdraw.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] _ in
                if let userInfo = self?.loadUserFromUserDefaults() {
                    switch userInfo.socialType {
                    case .kakao:
                        self?.unlinkKakao()
                    case .apple:
                        self?.unlilnkApple()
                    }
                }
                self?.deleteUserFromUserDefaults()
                self?.currentMember = nil
                self?.isLoggedIn = false
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
    
    func deleteUserFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "loggedInUser")
    }
    
    private func checkLoginStatus() {
        if let userInfo = loadUserFromUserDefaults() {
            switch userInfo.socialType {
            case .kakao:
                self.fetchUserInfo { result in
                    switch result {
                    case .success(let user):
                        let id = String(user.id!)
                        self.signIn(userInfo.socialToken, id) { success in
                            if success, let token = self.token {
                                let userInfo = UserInfo(userId: id, socialToken: userInfo.socialToken, token: token, socialType: .kakao)
                                self.saveUserToUserDefaults(userInfo)
                                self.getMemberInfo(token) { success in
                                    if let curMember = self.currentMember {
                                        InfoCollectionViewModel.shared.age = curMember.age.map { String($0) } ?? ""
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
            case .apple:
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                self.token = userInfo.token
                appleIDProvider.getCredentialState(forUserID: userInfo.userId) { credentialState, error in
                    switch credentialState {
                    case .authorized:
                        self.getMemberInfo(userInfo.token) { success in
                            if let curMember = self.currentMember {
                                InfoCollectionViewModel.shared.age = curMember.age.map { String($0) } ?? ""
                                InfoCollectionViewModel.shared.gender = curMember.gender ?? Gender.MOCK_GENDERS[0]
                                self.isLoggedIn = true
                                print("Succeed to sign-in! \(userInfo)")
                            }
                        }
                    case .revoked, .notFound:
                        print("Apple ID is not authorized or not found.")
                        self.isLoggedIn = false
                    default:
                        break
                    }
                }
            }
        } else {
            print("No user information found.")
            self.isLoggedIn = false
        }
    }

}

enum SocialType: String, Codable {
    case kakao
    case apple
}

struct UserInfo: Codable {
    let userId: String
    let socialToken: String
    let token: String
    let socialType: SocialType
}
