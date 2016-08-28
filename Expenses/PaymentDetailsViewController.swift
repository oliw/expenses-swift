//
//  PaymentDetailsViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UITableViewController, UITextFieldDelegate {

    var event:Event?
    var expense:Expense?
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var parts = textField.text!.componentsSeparatedByString(".")
        var fractionalPart: String?
        if (parts.count == 2) {
            fractionalPart = parts[1]
        }
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return fractionalPart?.characters.count < 2
        case ".":
            return fractionalPart == nil
        default:
            return string.isEmpty
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ReviewExpenseSegue" {
            let destination = segue.destinationViewController as? ReviewNewExpenseViewController
            let parts = amountTextField.text!.componentsSeparatedByString(".")
            var amountPaidIntegerPart = 0
            var amountPaidFractionalPart = 0
            if parts[0].characters.count > 0 {
                amountPaidIntegerPart = Int(parts[0])!
            }
            if parts.count == 2 {
                amountPaidFractionalPart = Int(parts[1])!
            }
            self.expense?.amount_integer_part = amountPaidIntegerPart
            self.expense?.amount_fraction_part = amountPaidFractionalPart
            self.expense?.details = detailsTextField.text
            self.expense?.date = NSDate()
            destination?.event = self.event
            destination?.expense = self.expense
        }
        
    }
}
