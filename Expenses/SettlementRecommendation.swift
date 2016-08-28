//
//  PaybackRecommendation.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/28/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

struct SettlementRecommendation {
    let from: Person
    let to: Person
    let amount: Amount
    
    init(from: Person, to: Person, amount: Amount) {
        self.from = from
        self.to = to
        self.amount = amount
    }
}