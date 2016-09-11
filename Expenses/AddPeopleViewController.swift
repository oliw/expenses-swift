//
//  AddPeopleViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/8/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import ContactsUI

class AddPeopleViewController: UITableViewController, CNContactPickerDelegate {
    
    var event:Event?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func onSaveButtonPress(sender: AnyObject) {
        let name = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if name != nil && !name!.isEmpty {
            PersonService.sharedInstance.createPerson(name!, event: event!)
        }
        performSegueWithIdentifier("doneExitSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        textField.text = personName
    }
    
    // MARK: - Table
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
