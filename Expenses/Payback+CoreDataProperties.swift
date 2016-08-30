//
//  Payback+CoreDataProperties.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Payback {

    @NSManaged var amount_integer_part: NSNumber?
    @NSManaged var amount_decimal_part: NSNumber?
    @NSManaged var paid_back_at: NSDate?
    @NSManaged var sender: Person?
    @NSManaged var receiver: Person?

}
