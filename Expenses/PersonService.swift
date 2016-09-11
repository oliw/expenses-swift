//
//  PersonService.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/11/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PersonService {
    
    class var sharedInstance: PersonService {
        struct Singleton {
            static let instance = PersonService()
        }
        return Singleton.instance
    }
    
    func createPerson(name: String, event: Event) -> Person {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let newPerson = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Person
        newPerson.name = name
        event.addPeopleObject(newPerson)
        return newPerson
    }
}
