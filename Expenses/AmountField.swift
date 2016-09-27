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
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
