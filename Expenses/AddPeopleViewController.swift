//
//  AddPeopleViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/8/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import ContactsUI

class AddPeopleViewController: UIViewController, UITableViewDataSource, CNContactPickerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var selectedNames: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contactsTableView.dataSource = self
        textField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Field
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // TODO Add new selectedName
        var input = textField.text!
        input = input.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if input.characters.last != nil && input.characters.last! != "," {
            let names = input.componentsSeparatedByString(",").map({word in word.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
            textField.text = names.joinWithSeparator(", ")+", "
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        NSLog("Nothing")
    }
    
    // MARK: - Contact Picker
    
    @IBAction func showContactPicker(sender: AnyObject) {
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.predicateForSelectionOfContact = NSPredicate(value: true)
        contactPickerViewController.predicateForSelectionOfProperty = NSPredicate(value: false)
        contactPickerViewController.delegate = self
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        var personName = contact.givenName
        if contact.familyName != "" {
            personName += " " + contact.familyName
        }
        
        var input = textField.text!
        input = input.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var names = input.componentsSeparatedByString(",").map({word in word.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
        names = names.filter({name in name != ""})
        names.append(personName)
        textField.text = names.joinWithSeparator(", ")+", "
    }
    
    // MARK: - Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("Contact Cell")!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
