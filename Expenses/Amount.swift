//
//  Amount.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/17/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

struct Amount {
    let decimalValue: Int
    
    static let decimalsInInteger = 100
    
    init(integerPart: Int, decimalPart: Int) {
        self.decimalValue = integerPart * Amount.decimalsInInteger + decimalPart
    }
    
    func toDecimalValue() -> Int {
        return decimalValue
    }
    
    func integerPart() -> Int {
        return decimalValue / Amount.decimalsInInteger
    }
    
    func decimalPart() -> Int {
        return decimalValue % Amount.decimalsInInteger
    }
    
    func isZero() -> Bool {
        return decimalValue == 0
    }
    
    static func zero() -> Amount {
        return Amount(integerPart: 0,decimalPart: 0)
    }
    
    static func smallestAmount() -> Amount {
        return Amount(integerPart: 0,decimalPart: 1)
    }
    
    static func fromDecimalValue(_ value: Int) -> Amount {
        let integerPart = value / Amount.decimalsInInteger
        let decimalPart = value % Amount.decimalsInInteger
        return Amount(integerPart: integerPart, decimalPart: decimalPart)
    }
}

func +(left: Amount, right: Amount) -> Amount {
    return Amount.fromDecimalValue(left.decimalValue + right.decimalValue)
}

func -(left: Amount, right: Amount) -> Amount {
    return Amount.fromDecimalValue(left.decimalValue - right.decimalValue)
}

func /(left: Amount, right: Int) -> Amount {
    let value = left.decimalValue / right
    return Amount.fromDecimalValue(value)
}

func %(left:Amount, right: Int) -> Amount {
    let value = left.decimalValue % right
    return Amount.fromDecimalValue(value)
}

func >(left:Amount, right: Amount) -> Bool {
    return left.decimalValue > right.decimalValue
}

func >=(left:Amount, right: Amount) -> Bool {
    return left.decimalValue >= right.decimalValue
}

func <(left:Amount, right:Amount) -> Bool {
    return left.decimalValue < right.decimalValue
}

func abs(_ amount:Amount) -> Amount {
    return Amount.fromDecimalValue(abs(amount.decimalValue))
}
