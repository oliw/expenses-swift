//
//  ChoosePeopleViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class ChoosePeopleViewController: UITableViewController {
    
    var event:Event?
    var expense:Expense?
    
    var checkedPeople = [Person]()
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkedPeople.removeAll()
        expense?.getParticipants().forEach({person -> Void in
            checkedPeople.append(person)
        })
        checkedPeopleChanged()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func checkedPeopleChanged() {
        if checkedPeople.isEmpty {
            doneButton.enabled = false
            doneButton.tintColor = UIColor.clearColor()
        } else {
            doneButton.enabled = true
            doneButton.tintColor = nil
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event!.getPeople().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell", forIndexPath: indexPath)
        let person = event!.getPeople()[indexPath.row]
        cell.textLabel?.text = person.name
        if (checkedPeople.contains(person)) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let person = event!.getPeople()[indexPath.row]
        if checkedPeople.contains(person) {
            let x = checkedPeople.indexOf(person)
            checkedPeople.removeAtIndex(x!)
        } else {
            checkedPeople.append(person)
        }
        checkedPeopleChanged()
        tableView.reloadData()
    }
    
    // MARK: - Action
    
    @IBAction func onDoneButtonPressed(sender: AnyObject) {
        let participants = expense?.getParticipants()
        participants?.forEach { expense?.removeParticipantsObject($0) }
        checkedPeople.forEach { expense?.addParticipantsObject($0) }
        
        performSegueWithIdentifier("addPeopleExitSegue", sender: sender)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
