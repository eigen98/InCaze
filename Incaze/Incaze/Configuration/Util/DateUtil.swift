//
//  DateUtil.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import Foundation
struct DateUtil{
    static func extractDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func extractTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    static func getCurrentDay() -> Int {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return Int(formatter.string(from: date)) ?? 0
    }
}
