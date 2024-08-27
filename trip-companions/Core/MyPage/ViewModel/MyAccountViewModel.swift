//
//  MyAccountViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import Foundation

class MyAccountViewModel: ObservableObject {
    @Published var isConnectedKakao: Bool = true
    
    func toNumberFormat(_ number: String) -> String {
        guard number.count == 11 else {
            return number
        }
        
        let pattern = "(\\d{3})(\\d{4})(\\d{4})"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        let range = NSRange(location: 0, length: number.utf16.count)
        let formattedNumber = regex.stringByReplacingMatches(in: number, options: [], range: range, withTemplate: "$1-$2-$3")
        
        return formattedNumber
    }
}
