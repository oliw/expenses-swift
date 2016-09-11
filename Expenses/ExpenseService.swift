//
//  ExpenseService.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/11/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ExpenseService {
    
    class var sharedInstance: ExpenseService {
        struct Singleton {
            static let instance = ExpenseService()
        }
        return Singleton.instance
    }
    
    func initExpense(event: Event) -> Expense {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: managedContext)
        let expense = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Expense
        event.addExpensesObject(expense)
        return expense
    }
}
