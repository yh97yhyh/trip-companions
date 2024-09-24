//
//  NetworkManager.swift
//  trip-companions
//
//  Created by 영현 on 8/12/24.
//

import Foundation
import Alamofire
import Combine

enum APIRouter: URLRequestConvertible {
    case fetchKakaoOAuthCode(Parameters)
    case postSignIn(Parameters)
    
    case createTripCompanion(Parameters)
    case updateTripCompanion(Parameters)
    case deleteTripCompanion(postId: Int)
    case getMyTripCompanions(Parameters)
    
    case createLikeTripCompanion(Parameters)
    case deleteLikeTripCompanion(postId: Int)
    case getMyLikeTripCompanions(Parameters)
    
    case updateMemberProfile(Parameters)
    case updateProfileImage(profileImageFile: UIImage?)
    case getMemberProfile
    case updateInterestRegion(Parameters)
    case getGenderAndMbti
    
    case getTripCompanions(Parameters)
    case getRecommendedTripCompanions(Parameters)
    
    case getMetaData
    
    var method: HTTPMethod {
        switch self {
        case .fetchKakaoOAuthCode,
                .getMyTripCompanions,
                .getMemberProfile, .getGenderAndMbti,
                .getRecommendedTripCompanions,
                .getMyLikeTripCompanions,
                .getTripCompanions,
                .getMetaData:
            return .get
        case .postSignIn, .createTripCompanion, .createLikeTripCompanion:
            return .post
        case .updateTripCompanion, .updateMemberProfile, .updateProfileImage, .updateInterestRegion:
            return .patch
        case .deleteTripCompanion, .deleteLikeTripCompanion:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .fetchKakaoOAuthCode:
            return "/oauth2/code/kakao"
        case .postSignIn:
            return "/oauth2/kakao/sign-in"
        case .createTripCompanion:
            return "/api/v1/trip-companions"
        case .updateTripCompanion:
            return "/api/v1/trip-companions"
        case .deleteTripCompanion(let postId):
            return "/api/v1/trip-companions/\(postId)"
        case .getMyTripCompanions:
            return "/api/v1/trip-companions/my"
        case .createLikeTripCompanion:
            return "/api/v1/interest-trip-companions"
        case .deleteLikeTripCompanion(let postId):
            return "/api/v1/interest-trip-companions/\(postId)"
        case .getMyLikeTripCompanions:
            return "/api/v1/interest-trip-companions/my"
        case .updateMemberProfile:
            return "/api/v1/members/profile"
        case .updateProfileImage:
            return "/api/v1/members/profile-image"
        case .updateInterestRegion:
            return "/api/v1/members/interest-region"
        case .getMemberProfile:
            return "/api/v1/members/my"
        case .getGenderAndMbti:
            return "/api/v1/members/filter-info"
        case .getTripCompanions:
            return "/public/v1/trip-companions"
        case .getRecommendedTripCompanions:
            return "/public/v1/trip-companions/recommend"
        case .getMetaData:
            return "/public/v1/meta"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchKakaoOAuthCode(let parameters),
                .postSignIn(let parameters),
                .getTripCompanions(let parameters),
                .createTripCompanion(let parameters),
                .updateTripCompanion(let parameters),
                .getMyTripCompanions(let parameters),
                .createLikeTripCompanion(let parameters),
                .getMyLikeTripCompanions(let parameters),
                .updateMemberProfile(let parameters),
                .updateInterestRegion(let parameters),
                .getRecommendedTripCompanions(let parameters):
            return parameters
        case .deleteTripCompanion, .deleteLikeTripCompanion, .updateProfileImage, .getMemberProfile, .getGenderAndMbti, .getMetaData:
            return Parameters()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .updateProfileImage(let profileImageFile):
            return profileImageFile
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try API.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        if case .updateProfileImage(_) = self {
            urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        } else {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if case .postSignIn(_) = self {
            
        } else if case .getMetaData = self {
            
        } else if case .getRecommendedTripCompanions(_) = self {
            
        } else if case .getTripCompanions(_) = self {
            
        }
        else {
            urlRequest.setValue("Bearer \(AuthManager.shared.token!)", forHTTPHeaderField: "Authorization")
        }
        
        switch method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            if let image = image {
                // Do not set Content-Type here for multipart/form-data
            } else {
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        }
        
        return urlRequest
    }
}

final class NetworkManager<T: Codable> {
    static func request(route: APIRouter) -> AnyPublisher<T, NetworkError> {
        return AF.request(route)
            .validate()
            .publishDecodable(type: T.self)
            .tryMap { response -> T in
                guard let value = response.value else {
                    if let error = response.error {
                        print("Failed to request \(route).. \(error.localizedDescription)")
                        throw NetworkError.error(err: error.localizedDescription)
                    }
                    throw NetworkError.error(err: "Decodin error")
                }
                return value
            }
            .mapError { error -> NetworkError in
                if let statusCode = (error.asAFError?.responseCode) {
                    switch statusCode {
                    case 401:
                        return .error(err: "Unauthorized")
                    default:
                        return .error(err: "Status code: \(statusCode)")
                    }
                } else {
                    return .error(err: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func requestWithoutResponse(route: APIRouter) -> AnyPublisher<Int, Never> {
        return AF.request(route)
            .validate()
            .publishData()
            .map { _ in return 1 }
            .replaceError(with: 0)
            .eraseToAnyPublisher()
    }
    
    static func requestFormData(route: APIRouter) -> AnyPublisher<T, NetworkError> {
            return Future<T, NetworkError> { promise in
                AF.upload(multipartFormData: { multipartFormData in
//                    if let parameters = route.parameters,
//                       let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
//                        multipartFormData.append(jsonData, withName: "saveRequest", mimeType: "application/json")
//                    }
                    
                    if let image = route.image {
                        if let imageData = image.jpegData(compressionQuality: 0.7) {
                            multipartFormData.append(imageData, withName: "profileImageFile", fileName: "image.jpg", mimeType: "image/jpeg")
                        }
                    }
                }, with: route)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                promise(.failure(.error(err: "Unauthorized")))
                            default:
                                promise(.failure(.error(err: "Status code: \(statusCode)")))
                            }
                        } else {
                            promise(.failure(.error(err: error.localizedDescription)))
                        }
                    }
                }
            }
            .eraseToAnyPublisher()
        }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}
