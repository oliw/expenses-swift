//
//  ActivityService.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/29/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation


class ActivityService {
    
    class var sharedInstance: ActivityService {
        struct Singleton {
            static let instance = ActivityService()
        }
        return Singleton.instance
    }
    
    func getActivity(event: Event) -> Activity {
        return Activity(expenses: event.getExpenses(), paybacks: event.getPaybacks())
    }
}
