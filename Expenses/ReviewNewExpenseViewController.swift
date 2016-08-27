//
//  ReviewNewExpenseViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/17/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class ReviewNewExpenseViewController: UIViewController {
    
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

}
