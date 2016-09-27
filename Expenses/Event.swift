//
//  Event.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/19/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation
import CoreData


class Event: NSManagedObject {

    func getNumberOfPeople() -> Int {
        return self.people!.count
    }
    
    func getPeople() -> [Person] {
        return self.people!.allObjects as! [Person]
    }
    
    @NSManaged func addPeopleObject(_ value:Person)
    @NSManaged func removePeopleObject(_ value:Person)
    
    func getNumberOfExpenses() -> Int {
        return self.expenses!.count
    }
    
    func getExpenses() -> [Expense] {
        return self.expenses!.allObjects as! [Expense]
    }
    
    func getPaybacks() -> [Payback] {
        return self.paybacks!.allObjects as! [Payback]
    }
    
    func getNumberOfPaybacks() -> Int {
        return self.paybacks!.count
    }
    
    @NSManaged func addPaybacksObject(_ value:Payback)
    @NSManaged func removePaybacksObject(_ value:Payback)
    
    @NSManaged func addExpensesObject(_ value:Expense)
    @NSManaged func removeExpensesObject(_ value:Expense)
}
