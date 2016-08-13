//
//  PaymentPaidCell.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/13/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class PaymentPaidCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var personPicker: UIPickerView!
    
    var people:[Person] = peopleData
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personPicker.dataSource = self
        personPicker.delegate = self
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return peopleData[row].name
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return peopleData.count
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
