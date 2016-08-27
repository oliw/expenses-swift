//
//  Expense+CoreDataProperties.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Expense {

    @NSManaged var amount_fraction_part: NSNumber?
    @NSManaged var amount_integer_part: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var details: String?
    @NSManaged var participants: NSSet?
    @NSManaged var payer: Person?

}
