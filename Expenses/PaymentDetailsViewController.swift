//
//  PaymentDetailsViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var amountTextField: UITextField!
    
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
}
