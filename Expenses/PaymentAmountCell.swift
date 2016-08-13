//
//  PaymentAmountCell.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class PaymentAmountCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let parts = textField.text!.componentsSeparatedByString(".")
        var fractionalPart: String?
        if parts.count == 2 {
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
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
