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
    case fetchTripCompanions(Parameters)
    case createTripCompanion(Parameters)
    case updateMemberProfile(Parameters, toekn: String)
    case fetchKakaoOAuthCode(Parameters)
    case postSignIn(Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .fetchTripCompanions, .fetchKakaoOAuthCode:
            return .get
        case .createTripCompanion:
            return .post
        case .updateMemberProfile, .postSignIn:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .fetchTripCompanions:
            return "/api/v1/trip-companions"
        case .createTripCompanion:
            return "/api/v1/trip-companions"
        case .updateMemberProfile:
            return "/api/v1/members/profile"
        case .fetchKakaoOAuthCode:
            return "/oauth2/code/kakao"
        case .postSignIn:
            return "/oauth2/kakao/sign-in"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchTripCompanions(let parameters),
                .createTripCompanion(let parameters),
                .updateMemberProfile(let parameters, _),
                .fetchKakaoOAuthCode(let parameters),
                .postSignIn(let parameters):
            return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try API.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
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
                        print("Failed to request.. \(error.localizedDescription)")
                        throw NetworkError.error(err: error.localizedDescription)
                    }
                    throw NetworkError.error(err: "Decoding error")
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
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}
