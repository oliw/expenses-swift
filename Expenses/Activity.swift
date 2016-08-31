//
//  Activity.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

class Activity {
    
    let items: [ActivityItem]
    
    init(expenses: [Expense], paybacks: [Payback]) {
        let unsorted_items = expenses.map({$0 as ActivityItem}) + paybacks.map({$0 as ActivityItem})
        self.items = unsorted_items.sort { (a:ActivityItem, b:ActivityItem) -> Bool in
            a.getDate().compare(b.getDate()) == .OrderedAscending
        }
    }
    
    func count() -> Int {
        return items.count
    }
    
    func getItem(i:Int) -> ActivityItem {
        return items[i]
    }
    
}