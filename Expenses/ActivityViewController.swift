//
//  ActivityViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/1/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData

class ActivityViewController: UITableViewController {
    
    var event:Event?
    var activity:Activity?


    @IBOutlet var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let parentTabController = self.tabBarController! as! EventViewController
        event = parentTabController.event
        
        let activityService = ActivityService.sharedInstance
        self.activity = activityService.getActivity(event!)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.parent?.navigationItem.setRightBarButton(addButton, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        return self.activity!.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityItem = activity!.getItem((indexPath as NSIndexPath).row)
        if activityItem.activityType == .expense {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath)
            let expense = activityItem as! Expense
            cell.textLabel?.text = expense.details
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaybackCell", for: indexPath)
            let payback = activityItem as! Payback
            let fromName = payback.sender!.name!
            let toName = payback.receiver!.name!
            let amount = AmountHelper.prettyAmount(payback.getAmount())
            cell.textLabel?.text = "\(fromName) gave \(toName) \(amount)"
            return cell
        }
    }
    
    @IBAction func cancelToPaymentsViewController(_ segue:UIStoryboardSegue) {
        // TODO - This feels hacky
        self.parent?.navigationItem.rightBarButtonItem = self.addButton
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this?", preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
                // Do nothing
            }
            let secondAction = UIAlertAction(title: "Delete", style: .destructive) { (alert: UIAlertAction!) -> Void in
                // Delete the row from the data source
                let activityItem = self.activity!.getItem((indexPath as NSIndexPath).row)
                ActivityService.sharedInstance.deleteActivityItem(activityItem, event: self.event!)
                self.activity = ActivityService.sharedInstance.getActivity(self.event!)
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

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "NewExpenseSegue" {
            let destinationNav = segue.destination as? UINavigationController
            let destination = destinationNav?.topViewController as? NewExpenseViewController
            destination?.event = event
        } else if segue.identifier == "ViewExpenseSegue" {
            let destination = segue.destination as? ExpenseDetailsViewController
            let expenseIndex = (tableView.indexPathForSelectedRow! as NSIndexPath).row
            destination?.expense = self.activity!.getItem(expenseIndex) as? Expense
        } else if segue.identifier == "ViewPaybackSegue" {
            let destination = segue.destination as? PaybackDetailsViewController
            let paybackIndex = (tableView.indexPathForSelectedRow! as NSIndexPath).row
            destination?.payback = self.activity!.getItem(paybackIndex) as? Payback
        }
    }
    
    @IBAction func returnToActivityView(_ segue:UIStoryboardSegue) {
        if segue.identifier == "saveExitSegue" {
            self.tableView.reloadData()
        }
    }
}
