//
//  NewExpenseViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/1/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class NewExpenseViewController: UITableViewController, UITextFieldDelegate {

    var event:Event?
    var expense:Expense?
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var payerDetailField: UILabel!
    @IBOutlet weak var peopleDetailField: UILabel!
    
    var amountFractional:Int?
    var amountInteger = 0
    let maxAmountCents = 10000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if expense == nil {
            expense = ExpenseService.sharedInstance.initExpense(event!)
        }
        
        amountTextField.delegate = self
        payerDetailField.text = expense?.payer?.name
        peopleDetailField.text = "\(expense!.getNumberOfParticipants())"
        
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
    
    // MARK :- Payment Details Text Field
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            if (amountFractional != nil) {
                if (amountFractional! / 10 == 0) {
                    amountFractional! *= 10
                    amountFractional! += Int(string)!
                } else {
                    return false
                }
            } else {
                if (string == "0" && amountInteger == 0) {
                    return false
                } else {
                    amountInteger *= 10
                    amountInteger += Int(string)!
                }
            }
        case ".":
            if (amountFractional != nil) {
                return false
            } else {
                amountFractional = 0
            }
        case "":
            if (amountFractional != nil) {
                if amountFractional! == 0 {
                    amountFractional = nil
                } else {
                    amountFractional! /= 10
                }
            } else {
                amountInteger /= 10
            }
            
        default:
            return false
        }
        setAmountField(amountInteger, amountFractional: amountFractional)
        return false
    }
    
    func setAmountField(amountInteger: Int, amountFractional: Int?) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var unformattedDollars = 0.0
        if amountFractional != nil {
            unformattedDollars = Double(amountInteger) + Double(amountFractional!)/100
            formatter.maximumFractionDigits = 2
        } else {
            unformattedDollars = Double(amountInteger)
            formatter.maximumFractionDigits = 0
        }
        self.amountTextField.text = formatter.stringFromNumber(unformattedDollars)
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.rollback()
        performSegueWithIdentifier("cancelExitSegue", sender: sender)
    }
    
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.save()
            performSegueWithIdentifier("saveExitSegue", sender: sender)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationNav = segue.destinationViewController as! UINavigationController
        if segue.identifier == "ChoosePayerSegue" {
            let destination = destinationNav.topViewController as! ChoosePayerViewController
            destination.event = self.event
            destination.expense = self.expense
        } else if segue.identifier == "addPeopleSegue" {
            let destination = destinationNav.topViewController as! ChoosePeopleViewController
            destination.event = self.event
            destination.expense = self.expense
        }
        
    }
    
    @IBAction func returnToNewExpenseView(segue:UIStoryboardSegue) {
        if segue.identifier == "addPeopleExitSegue" {
            peopleDetailField.text = "\(expense!.getNumberOfParticipants())"
        } else if segue.identifier == "addPayerExitSegue" {
            payerDetailField.text = expense?.payer?.name
        }
    }
    

}
