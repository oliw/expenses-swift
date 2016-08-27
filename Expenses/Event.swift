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
    
    func addPerson(person:Person) -> Void {
        self.mutableSetValueForKey("people").addObject(person)
    }
    
    func removePerson(person:Person) -> Void {
        self.mutableSetValueForKey("people").removeObject(person)
    }
    
    func getNumberOfExpenses() -> Int {
        return self.expenses!.count
    }
    
    func getExpenses() -> [Expense] {
        return self.expenses!.allObjects as! [Expense]
    }
    
    func removeExpense(expense:Expense) -> Void {
        self.mutableSetValueForKey("expenses").removeObject(expense)
    }
}
