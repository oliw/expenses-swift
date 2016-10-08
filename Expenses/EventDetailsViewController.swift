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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //nameTextField.becomeFirstResponder()
        peopleLabelField.text = String(self.event!.getNumberOfPeople())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 {
            nameTextField.becomeFirstResponder()
        } else if (indexPath as NSIndexPath).section == 1 {
            self.performSegue(withIdentifier: "viewPeopleSegue", sender: self)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        let name = nameTextField.text!
        if !name.isEmpty {
            let strippedName = name.trimmingCharacters(in: CharacterSet.whitespaces)
            event?.name = strippedName
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.save()
            performSegue(withIdentifier: "saveExitSegue", sender: sender)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.rollback()
            performSegue(withIdentifier: "cancelExitSegue", sender: sender)
        } catch let error as NSError  {
            print("Could not rollback \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewPeopleSegue" {
            event?.name = nameTextField.text
            let destination = segue.destination as? PeopleViewController
            destination?.event = event
        }
    }
 

}
