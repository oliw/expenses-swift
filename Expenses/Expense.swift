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
    
    func getAmount() -> Amount {
        let integerPart = self.amount_integer_part! as Int
        let decimalPart = self.amount_fraction_part! as Int
        return Amount(integerPart: integerPart, decimalPart: decimalPart)
    }
    
    @NSManaged func addParticipants(value:Set<Person>)
    @NSManaged func addParticipantsObject(value:Person)
    @NSManaged func removeParticipantsObject(value:Person)
    
    func replaceParticipants(people:[Person]) -> Void {
        self.mutableSetValueForKey("participants").removeAllObjects()
        addParticipants(Set(people))
    }
    
    func getAmountOwedFor(person: Person) -> Amount {
        let amount = getAmount()
        let participants = getParticipants()
        let n = getNumberOfParticipants()
        
        let baseAmount = amount / n
        let residualAmount = amount % n
        let extras = residualAmount.decimalValue
        
        
        if participants.contains(person) {
            let index = participants.indexOf(person)!
            if (index < extras) {
                return baseAmount + Amount.smallestAmount()
            } else {
                return baseAmount
            }
        } else {
            return Amount.zero()
        }
    }
}
