//
//  ActivityService.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit


class ActivityService {
    
    class var sharedInstance: ActivityService {
        struct Singleton {
            static let instance = ActivityService()
        }
        return Singleton.instance
    }
    
    func getActivity(event: Event) -> Activity {
        return Activity(expenses: event.getExpenses(), paybacks: event.getPaybacks())
    }
    
    func deleteActivityItem(item: ActivityItem, event: Event) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        if item.activityType == .Expense {
            let expense = item as! Expense
            event.removeExpensesObject(expense)
            managedContext.deleteObject(expense)
        } else {
            let payback = item as! Payback
            event.removePaybacksObject(payback)
            managedContext.deleteObject(payback)
        }
        do {
            try managedContext.save()
        } catch _ {}
    }
}
