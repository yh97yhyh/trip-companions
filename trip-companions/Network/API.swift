//
//  API.swift
//  trip-companions
//
//  Created by 영현 on 8/18/24.
//

import Foundation


class API {
    static var baseUrlString: String {
        #if DEBUG
        return "http://52.78.245.140:8080"
        #else
        return "http://52.78.245.140:8080"
        #endif
    }
}
