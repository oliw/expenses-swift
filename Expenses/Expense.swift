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
    
    @NSManaged func addParticipants(value:Set<Person>)
    
    @NSManaged func addParticipantsObject(value:Person)
    @NSManaged func removeParticipantsObject(value:Person)
    
    func replaceParticipants(people:[Person]) -> Void {
        self.mutableSetValueForKey("participants").removeAllObjects()
        addParticipants(Set(people))
    }
}
