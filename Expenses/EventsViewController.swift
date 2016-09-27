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
        events = EventService.sharedInstance.getEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        let event = events[(indexPath as NSIndexPath).row]
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this event?", preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
                // Do nothing
            }
            let secondAction = UIAlertAction(title: "Delete", style: .destructive) { (alert: UIAlertAction!) -> Void in
                let event = self.events[(indexPath as NSIndexPath).row]
                EventService.sharedInstance.deleteEvent(event)
                self.events = EventService.sharedInstance.getEvents()
                tableView.reloadData()
            }
            alert.addAction(firstAction)
            alert.addAction(secondAction)
            present(alert, animated: true, completion:nil)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == eventSegueIdentifier {
            let destination = segue.destination as? EventViewController
            let eventIndex = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row
            destination?.event = events[eventIndex!]
        } else if segue.identifier == addEventSegueIdentifier {
            let destination = segue.destination as? UINavigationController
            let topDestination = destination?.topViewController as? EventDetailsViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)
            let newEvent = NSManagedObject(entity: entity!, insertInto: managedContext) as! Event
            topDestination?.event = newEvent
        }
    }
    
    @IBAction func returnToEventsView(_ segue:UIStoryboardSegue) {
        if segue.identifier == "saveExitSegue" {
            self.events = EventService.sharedInstance.getEvents()
            tableView.reloadData()
        }
    }
}
