//
//  NetworkManager.swift
//  trip-companions
//
//  Created by 영현 on 8/12/24.
//

import Foundation
import Alamofire
import Combine

//enum APIRouter: URLRequestConvertible {
//    case fetchTripCompanions
//    case createTripCompanion
//    case updateMemberProfile
//    case fetchKakaoOAuthCode
//    
//    func asURLRequest() throws -> URLRequest {
//        <#code#>
//    }
//}
//
//final class NetworkManager<T: Codable> {
//    static func request(route: APIRouter) -> AnyPublisher<T, NetworkError> {
//        return AF.request(route)
//            .validate()
//            .publishDecodable(type: T.self)
//            .tryMap { response -> T in
//                guard let value = response.value else {
//                    throw NetworkError.error(err: "Decoding error")
//                }
//                return value
//            }
//            .mapError { error -> NetworkError in
//                if let statusCode = (error.asAFError?.responseCode) {
//                    switch statusCode {
//                    case 401:
//                        return .error(err: "Unauthorized")
//                    default:
//                        return .error(err: "Status code: \(statusCode)")
//                    }
//                } else {
//                    return .error(err: error.localizedDescription)
//                }
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    static func requestWithoutResponse(route: APIRouter) -> AnyPublisher<Int, Never> {
//        return AF.request(route)
//            .validate()
//            .publishData()
//            .map { _ in return 1 }
//            .replaceError(with: 0)
//            .eraseToAnyPublisher()
//    }
//}
//
//enum NetworkError: Error {
//    case invalidResponse
//    case invalidData
//    case error(err: String)
//    case decodingError(err: String)
//}
