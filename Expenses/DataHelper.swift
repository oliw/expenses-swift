//
//  DataHelper.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation
import CoreData

class DataHelper {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func seedDataStore() {
        seedMexicoEvent()
    }
    
    private func seedMexicoEvent() {
        // 1. Mexico Event
        let newEvent = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: context) as! Event
        newEvent.name = "Mexico"
        // 2. Mexico People
        let newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        newPerson.name = "Oli"
        let newPerson2 = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        newPerson2.name = "Liz"
        let newPerson3 = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        newPerson3.name = "Bogdan"
        newEvent.addPerson(newPerson)
        newEvent.addPerson(newPerson2)
        newEvent.addPerson(newPerson3)
        // 3. Mexico Expenses
        let newExpense = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: context) as! Expense
        newExpense.details = "Water Taxi Ticket"
        newExpense.date = DateHelper.fromIso8601("2016-08-27T22:54:57+00:00")
        newExpense.payer = newPerson
        newExpense.addParticipant(newPerson)
        newExpense.addParticipant(newPerson2)
        newExpense.addParticipant(newPerson3)
        newExpense.amount_integer_part = 10
        newExpense.amount_fraction_part = 0
        newEvent.addExpense(newExpense)
        do {
            try context.save()
        } catch _ {}
        return
    }
}