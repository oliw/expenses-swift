//
//  PaymentWhomCell.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class PaymentWhomCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uiSwitch: UISwitch!
    
    var person: Person?
    
    func setPerson(person: Person) {
        //self.person = person
        //label.text = person.name
        //uiSwitch.enabled = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
