//
//  EventService.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/11/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EventService {
    
    class var sharedInstance: EventService {
        struct Singleton {
            static let instance = EventService()
        }
        return Singleton.instance
    }
    
    func getEvents() -> [Event] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Event")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            return results as! [Event]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteEvent(event:Event) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.deleteObject(event)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}
