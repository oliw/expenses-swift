//
//  AmountHelper.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/28/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

class AmountHelper {
    static func prettyAmount(amount:Amount) -> String {
        var result = "$"
        result += String(amount.integerPart())
        result += "."
        if amount.decimalPart() < 10 {
         result += "0"
        }
        result += String(amount.decimalPart())
        return result
    }
}