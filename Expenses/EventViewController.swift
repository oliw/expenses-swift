//
//  EventViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/1/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class EventViewController: UITabBarController {
    
    var event:Event?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = event?.name
    }
}
