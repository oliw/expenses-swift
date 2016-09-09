//
//  PeopleViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/27/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData

class PeopleViewController: UITableViewController {
    
    var event:Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Actions

    @IBAction func addPerson(sender: AnyObject) {
        let alert = UIAlertController(title: "New Person",
                                      message: "Add a new person",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {(action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            let personName = textField?.text
            
            // create a person in the context
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: managedContext) as! Person
            newPerson.name = personName
            self.event?.addPeopleObject(newPerson)
            
            self.tableView.reloadData()
            
            return
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(action:UIAlertAction) -> Void in
            return
        })
        
        alert.addTextFieldWithConfigurationHandler({(textField:UITextField) -> Void in})
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event!.getNumberOfPeople() + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < event!.getNumberOfPeople() {
            let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath)
            
            let person = event!.getPeople()[indexPath.row]
            cell.textLabel?.text = person.name
            
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier("addPeopleCell", forIndexPath: indexPath)
        }
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
            // Delete the row from the data source
            let person = self.event!.getPeople()[indexPath.row]
            self.event?.removePeopleObject(person)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(person)
            do {
                try managedContext.save()
            } catch _ {}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
