//
//  EventDetailsViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 7/24/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class EventDetailsViewController: UITableViewController {
    var event:Event?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var peopleLabelField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
        peopleLabelField.text = String(self.event!.getNumberOfPeople())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        } else if indexPath.section == 1 {
            self.performSegueWithIdentifier("viewPeopleSegue", sender: self)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let name = nameTextField.text!
        if !name.isEmpty {
            let strippedName = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            event?.name = strippedName
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.save()
            performSegueWithIdentifier("saveExitSegue", sender: sender)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.rollback()
            performSegueWithIdentifier("cancelExitSegue", sender: sender)
        } catch let error as NSError  {
            print("Could not rollback \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewPeopleSegue" {
            event?.name = nameTextField.text
            let destination = segue.destinationViewController as? PeopleViewController
            destination?.event = event
        }
    }
 

}
