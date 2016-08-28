//
//  DateHelper.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

class DateHelper {
    static func fromIso8601(string:String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter.dateFromString(string)
    }
    
    static func prettyDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .NoStyle
        formatter.dateStyle = .ShortStyle
        formatter.doesRelativeDateFormatting = true
        
        let locale = NSLocale.currentLocale()
        formatter.locale = locale
        
        return formatter.stringFromDate(date)
    }
}