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
    
    var amountFractional:Int?
    var amountInteger = 0
    let maxAmountCents = 10000000
    var datePickerHidden = true
        
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var payerDetailField: UILabel!
    @IBOutlet weak var peopleDetailField: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateDetailField: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if expense == nil {
            expense = ExpenseService.sharedInstance.initExpense(event!)
            amountTextField.becomeFirstResponder()
        }
        
        amountTextField.delegate = self
        payerDetailField.text = expense?.payer?.name
        peopleDetailField.text = "\(expense!.getNumberOfParticipants())"
        datePicker.date = expense!.date! as Date
        datePickerChanged()
        
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
    
    // MARK :- Table
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.reuseIdentifier == "Date Field" {
            toggleDatePicker()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerHidden && (indexPath as NSIndexPath).section == 2 && (indexPath as NSIndexPath).row == 1 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK :- Payment Details Text Field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
    
    func setAmountField(_ amountInteger: Int, amountFractional: Int?) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        var unformattedDollars = 0.0
        if amountFractional != nil {
            unformattedDollars = Double(amountInteger) + Double(amountFractional!)/100
            formatter.maximumFractionDigits = 2
        } else {
            unformattedDollars = Double(amountInteger)
            formatter.maximumFractionDigits = 0
        }
        
        self.amountTextField.text = formatter.string(from: NSNumber(value: unformattedDollars))
    }
    
    // MARK: - Date Picker
    func datePickerChanged() {
        dateDetailField.text = DateHelper.prettyDate(datePicker.date)
    }
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func onDatePickerValueChange(_ sender: AnyObject) {
        datePickerChanged()
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.rollback()
        performSegue(withIdentifier: "cancelExitSegue", sender: sender)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        expense?.details = descriptionTextField.text
        expense?.amount_integer_part = amountInteger as NSNumber?
        expense?.amount_fraction_part = amountFractional as NSNumber?
        expense?.date = datePicker.date
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        do {
            try managedContext.save()
            performSegue(withIdentifier: "saveExitSegue", sender: sender)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ChoosePayerSegue" {
            let destinationNav = segue.destination as! UINavigationController
            let destination = destinationNav.topViewController as! ChoosePayerViewController
            destination.event = self.event
            destination.expense = self.expense
        } else if segue.identifier == "addPeopleSegue" {
            let destinationNav = segue.destination as! UINavigationController
            let destination = destinationNav.topViewController as! ChoosePeopleViewController
            destination.event = self.event
            destination.expense = self.expense
        }
        
    }
    
    @IBAction func returnToNewExpenseView(_ segue:UIStoryboardSegue) {
        if segue.identifier == "addPeopleExitSegue" {
            peopleDetailField.text = "\(expense!.getNumberOfParticipants())"
        } else if segue.identifier == "addPayerExitSegue" {
            payerDetailField.text = expense?.payer?.name
        }
    }
    

}
