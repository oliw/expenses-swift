//
//  EventsViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 7/24/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData

class EventsViewController: UITableViewController {
    
    var events = [Event]()
    let eventSegueIdentifier = "ShowEventSegue"
    let addEventSegueIdentifier = "AddEventSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Event")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            events = results as! [Event]
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = event.name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this event?", preferredStyle: .Alert)
            let firstAction = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) -> Void in
                // Do nothing
            }
            let secondAction = UIAlertAction(title: "Delete", style: .Destructive) { (alert: UIAlertAction!) -> Void in
                let event = self.events[indexPath.row]
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                managedContext.deleteObject(event)
                self.events.removeAtIndex(indexPath.row)
                do {
                    try managedContext.save()
                } catch _ {}
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            alert.addAction(firstAction)
            alert.addAction(secondAction)
            presentViewController(alert, animated: true, completion:nil)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == eventSegueIdentifier {
            let destination = segue.destinationViewController as? EventViewController
            let eventIndex = tableView.indexPathForSelectedRow?.row
            destination?.event = events[eventIndex!]
        } else if segue.identifier == addEventSegueIdentifier {
            let destination = segue.destinationViewController as? UINavigationController
            let topDestination = destination?.topViewController as? EventDetailsViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: managedContext)
            let newEvent = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Event
            topDestination?.event = newEvent
        }
    }
    
    @IBAction func cancelToEventsViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveEventDetail(segue:UIStoryboardSegue) {
        if let eventDetailsViewController = segue.sourceViewController as? EventPeopleDetailsViewController {
            
            //add the new player to the players array
            if let event = eventDetailsViewController.event {
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                do {
                    try managedContext.save()
                    events.append(event)
                } catch _ {}
                
                tableView.reloadData()
            }
        }
    }

}
