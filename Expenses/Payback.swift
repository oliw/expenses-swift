//
//  Payback.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation
import CoreData


class Payback: NSManagedObject, ActivityItem {

    let activityType: ActivityItemType = .Payback
    
    func getDate() -> NSDate {
        return self.paid_back_at!
    }

}
