//
//  ActivityItem.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

enum ActivityItemType {
    case Expense
    case Payback
}

protocol ActivityItem {
    func getDate() -> NSDate
    var activityType: ActivityItemType { get }
}