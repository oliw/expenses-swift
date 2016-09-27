//
//  PaymentPayerViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class ChoosePayerViewController: UITableViewController {

    var event:Event?
    var expense:Expense?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        // #warning Incomplete implementation, return the number of rows
        return event!.getNumberOfPeople()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayerCell", for: indexPath)
        let person = event!.getPeople()[(indexPath as NSIndexPath).row]
        if expense?.payer == person {
            cell.isSelected = true
            cell.accessoryType = .checkmark
            
        } else {
            cell.isSelected = false
            cell.accessoryType = .none
        }
        cell.textLabel?.text = person.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let payer = event?.getPeople()[(selectedIndex! as NSIndexPath).row]
        expense?.payer = payer
        performSegue(withIdentifier: "addPayerExitSegue", sender: self.view)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
