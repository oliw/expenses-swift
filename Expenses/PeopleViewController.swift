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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Actions

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event!.getNumberOfPeople() + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row < event!.getNumberOfPeople() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
            
            let person = event!.getPeople()[(indexPath as NSIndexPath).row]
            cell.textLabel?.text = person.name
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "addPeopleCell", for: indexPath)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let person = self.event!.getPeople()[(indexPath as NSIndexPath).row]
            self.event?.removePeopleObject(person)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.delete(person)
            do {
                try managedContext.save()
            } catch _ {}
            tableView.deleteRows(at: [indexPath], with: .fade)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addPersonSegue" {
            let navigationRootController = segue.destination as! UINavigationController
            let addPersonController = navigationRootController.topViewController as! AddPeopleViewController
            addPersonController.event = self.event
        }
        
    }
    
    @IBAction func prepareForAddPeopleUnwind(_ segue: UIStoryboardSegue) {
        if segue.identifier == "doneExitSegue" {
            tableView.reloadData()
        }
    }
}
