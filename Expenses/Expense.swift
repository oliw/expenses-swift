//
//  Expense.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation
import CoreData


class Expense: NSManagedObject {

    func getNumberOfParticipants() -> Int {
        return self.participants!.count
    }
    
    func getParticipants() -> [Person] {
        return self.participants!.allObjects as! [Person]
    }
    
    func removeParticipant(person:Person) -> Void {
        self.mutableSetValueForKey("participants").removeObject(person)
    }
    
    func addParticipant(person:Person) -> Void {
        self.mutableSetValueForKey("participants").addObject(person)
    }

}
