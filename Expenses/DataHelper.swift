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
        do {
            try context.save()
        } catch _ {}
        return
    }
    
}