//
//  Expense.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation
import CoreData


class Expense: NSManagedObject, ActivityItem {

    let activityType: ActivityItemType = .expense
    
    func getDate() -> Date {
        return self.date! as Date
    }
    
    func getNumberOfParticipants() -> Int {
        return self.participants!.count
    }
    
    var amount: Amount {
        get {
            let integerPart = self.amount_integer_part! as Int
            let decimalPart = self.amount_fraction_part! as Int
            return Amount(integerPart: integerPart, decimalPart: decimalPart)
        }
        set(newAmount) {
            self.amount_integer_part = NSNumber(value: newAmount.integerPart())
            self.amount_fraction_part = NSNumber(value: newAmount.decimalPart())
        }
    }
    
    @NSManaged func addParticipants(_ value:Set<Person>)
    @NSManaged func addParticipantsObject(_ value:Person)
    @NSManaged func removeParticipantsObject(_ value:Person)
    
    func replaceParticipants(_ people:[Person]) -> Void {
        self.mutableSetValue(forKey: "participants").removeAllObjects()
        addParticipants(Set(people))
    }
    
    func amountOwed(by person: Person) -> Amount {
        let n = getNumberOfParticipants()
        
        let baseAmount = amount / n // e.g. $3.23 / 3 = $1.07
        let residualAmount = amount % n // e.g. $3.23 % 3 = $0.02
        let extras = residualAmount.decimalValue
        
        if !participants!.contains(person) {
            return Amount.zero()
        }
        
        let i = participants!.index(of: person)
        
        if let index = i {
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
