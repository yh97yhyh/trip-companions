//
//  Date+Extension.swift
//  trip-companions
//
//  Created by 영현 on 8/19/24.
//

import Foundation

extension Date {
    func toDateText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    func toServerDateText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func toUnixTimestamp() -> Double {
        return self.timeIntervalSince1970
    }
    
    static func defaultDate() -> Date {
        let calendar = Calendar.current
        
        let now = Date()
    
        var dateComponents = DateComponents()
        dateComponents.year = calendar.component(.year, from: now)
        dateComponents.month = calendar.component(.month, from: now)
        dateComponents.day = calendar.component(.day, from: now)
        dateComponents.hour = 2
        dateComponents.minute = 2
        dateComponents.second = 2
        
        return calendar.date(from: dateComponents)!
    }
}
