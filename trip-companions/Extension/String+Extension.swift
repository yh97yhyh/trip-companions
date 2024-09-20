//
//  String+Extension.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import Foundation

extension String {
    func toCellDateFormat() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy.MM.dd"
        
        return outputFormatter.string(from: date)
    }
    
    func toDetailDateFormat() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M월 d일"
        
        return outputFormatter.string(from: date)
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return Date()
        }

    }
}
