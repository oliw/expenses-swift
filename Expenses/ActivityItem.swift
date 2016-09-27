//
//  ActivityItem.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

enum ActivityItemType {
    case expense
    case payback
}

protocol ActivityItem {
    func getDate() -> Date
    var activityType: ActivityItemType { get }
}
