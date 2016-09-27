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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = Event.fetchRequest()
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results as! [Event]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteEvent(_ event:Event) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.delete(event)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}
