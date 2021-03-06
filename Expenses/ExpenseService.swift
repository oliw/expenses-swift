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
    
    func initExpense(_ event: Event) -> Expense {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: managedContext)
        let expense = NSManagedObject(entity: entity!, insertInto: managedContext) as! Expense
        expense.date = Date()
        event.addExpensesObject(expense)
        return expense
    }
}
