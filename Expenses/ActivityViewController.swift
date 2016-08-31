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
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.parentViewController?.navigationItem.setRightBarButtonItem(addButton, animated: animated)
        
        // TODO - Is this the right way to do this?
        let parentTabController = self.tabBarController! as! EventViewController
        event = parentTabController.event
        
        let activityService = ActivityService.sharedInstance
        self.activity = activityService.getActivity(event!)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
        return self.activity!.count()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let activityItem = activity!.getItem(indexPath.row)
        if activityItem.activityType == .Expense {
            let cell = tableView.dequeueReusableCellWithIdentifier("PaymentCell", forIndexPath: indexPath)
            let expense = activityItem as! Expense
            cell.textLabel?.text = expense.details
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("PaybackCell", forIndexPath: indexPath)
            let payback = activityItem as! Payback
            let fromName = payback.sender!.name!
            let toName = payback.receiver!.name!
            let amount = AmountHelper.prettyAmount(payback.getAmount())
            cell.textLabel?.text = "\(fromName) gave \(toName) \(amount)"
            return cell
        }
    }
    
    @IBAction func cancelToPaymentsViewController(segue:UIStoryboardSegue) {
        // TODO - This feels hacky
        self.parentViewController?.navigationItem.rightBarButtonItem = self.addButton
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this?", preferredStyle: .Alert)
            let firstAction = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) -> Void in
                // Do nothing
            }
            let secondAction = UIAlertAction(title: "Delete", style: .Destructive) { (alert: UIAlertAction!) -> Void in
                // Delete the row from the data source
                let activityItem = self.activity!.getItem(indexPath.row)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                if activityItem.activityType == .Expense {
                    let expense = activityItem as! Expense
                    self.event?.removeExpensesObject(expense)
                    managedContext.deleteObject(expense)
                } else {
                    let payback = activityItem as! Payback
                    self.event?.removePaybacksObject(payback)
                    managedContext.deleteObject(payback)
                }
                do {
                    try managedContext.save()
                } catch _ {}
                let activityService = ActivityService.sharedInstance
                self.activity = activityService.getActivity(self.event!)
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

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "NewExpenseSegue" {
            let destinationNav = segue.destinationViewController as? UINavigationController
            let destination = destinationNav?.topViewController as? ChoosePayerViewController
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: managedContext)
            let newExpense = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Expense
            destination?.expense = newExpense
            destination?.event = event
        } else if segue.identifier == "ViewExpenseSegue" {
            let destination = segue.destinationViewController as? ExpenseDetailsViewController
            let expenseIndex = tableView.indexPathForSelectedRow!.row
            destination?.expense = self.activity!.getItem(expenseIndex) as? Expense
        }
    }
    
    @IBAction func saveExpense(segue:UIStoryboardSegue) {
        let origin = segue.sourceViewController as! PaymentDetailsViewController
        let event = origin.event
        let expense = origin.expense!
        event?.addExpensesObject(expense)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
    @IBAction func cancelExpense(segue:UIStoryboardSegue) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.rollback()
    }

}
