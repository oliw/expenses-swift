//
//  AmountField.swift
//  Expenses
//
//  Created by Oliver Wilkie on 9/1/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class AmountField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return false
    }
}
