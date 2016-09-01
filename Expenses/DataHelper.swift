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
        let oli = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        oli.name = "Oli"
        let liz = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        liz.name = "Liz"
        let bogdan = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        bogdan.name = "Bogdan"
        newEvent.addPeopleObject(oli)
        newEvent.addPeopleObject(liz)
        newEvent.addPeopleObject(bogdan)
        // 3. Oli spent $10 on Oli, Liz and Bogdan
        let newExpense = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: context) as! Expense
        newExpense.details = "Water Taxi Ticket"
        newExpense.date = DateHelper.fromIso8601("2016-08-27T22:54:57+00:00")
        newExpense.payer = oli
        newExpense.addParticipantsObject(oli)
        newExpense.addParticipantsObject(liz)
        newExpense.addParticipantsObject(bogdan)
        newExpense.amount_integer_part = 10
        newExpense.amount_fraction_part = 0
        newEvent.addExpensesObject(newExpense)
        // 4. Liz spent $20 on Oli, Liz and Bogdan
        let newExpense2 = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: context) as! Expense
        newExpense2.details = "Groceries"
        newExpense2.date = DateHelper.fromIso8601("2016-08-27T22:55:57+00:00")
        newExpense2.payer = liz
        newExpense2.addParticipantsObject(oli)
        newExpense2.addParticipantsObject(liz)
        newExpense2.addParticipantsObject(bogdan)
        newExpense2.amount_integer_part = 20
        newExpense2.amount_fraction_part = 0
        newEvent.addExpensesObject(newExpense2)
        // 5. Bodgan paid $10 Oli
        let newPayback = NSEntityDescription.insertNewObjectForEntityForName("Payback", inManagedObjectContext: context) as! Payback
        newPayback.receiver = oli
        newPayback.sender = bogdan
        newPayback.amount_integer_part = 10
        newPayback.paid_back_at = DateHelper.fromIso8601("2016-08-27T22:56:57+00:00")
        newEvent.addPaybacksObject(newPayback)
        do {
            try context.save()
        } catch _ {}
        return
    }
}