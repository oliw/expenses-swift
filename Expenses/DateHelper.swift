//
//  DateHelper.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

class DateHelper {
    static func fromIso8601(_ string:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter.date(from: string)
    }
    
    static func prettyDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        
        let locale = Locale.current
        formatter.locale = locale
        
        return formatter.string(from: date)
    }
}
