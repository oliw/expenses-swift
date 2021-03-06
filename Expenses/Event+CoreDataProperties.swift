//
//  Event+CoreDataProperties.swift
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

extension Event {

    @NSManaged var name: String?
    @NSManaged var expenses: NSSet?
    @NSManaged var people: NSSet?
    @NSManaged var paybacks: NSSet?

}
