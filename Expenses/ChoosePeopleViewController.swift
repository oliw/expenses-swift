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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func checkedPeopleChanged() {
        if checkedPeople.isEmpty {
            doneButton.isEnabled = false
            doneButton.tintColor = UIColor.clear
        } else {
            doneButton.isEnabled = true
            doneButton.tintColor = nil
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event!.getPeople().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        let person = event!.getPeople()[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = person.name
        if (checkedPeople.contains(person)) {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let person = event!.getPeople()[(indexPath as NSIndexPath).row]
        if checkedPeople.contains(person) {
            let x = checkedPeople.index(of: person)
            checkedPeople.remove(at: x!)
        } else {
            checkedPeople.append(person)
        }
        checkedPeopleChanged()
        tableView.reloadData()
    }
    
    // MARK: - Action
    
    @IBAction func onDoneButtonPressed(_ sender: AnyObject) {
        let participants = expense?.getParticipants()
        participants?.forEach { expense?.removeParticipantsObject($0) }
        checkedPeople.forEach { expense?.addParticipantsObject($0) }
        
        performSegue(withIdentifier: "addPeopleExitSegue", sender: sender)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
