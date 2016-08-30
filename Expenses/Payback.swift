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

    func getAmount() -> Amount {
        let integerPart = self.amount_integer_part! as Int
        let decimalPart = self.amount_decimal_part! as Int
        return Amount(integerPart: integerPart, decimalPart: decimalPart)
    }
}
