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
        let events = [
            (name: "Mexico", bar: 1),
            (name: "Boston", bar: 1)
        ]
        for event in events {
            let newEvent = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: context) as! Event
            newEvent.name = event.name
        }
        
        do {
            try context.save()
        } catch _ {}
        return  
    }
    
}