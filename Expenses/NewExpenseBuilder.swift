//
//  PaymentBuilder.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/17/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

struct NewExpenseBuilder {
    let event: Event
    let amountPaid: Amount?
    let personWhoPaid: Person?
    let peoplePaidFor: [Person]
    let paidForDescription: String?
}

extension NewExpenseBuilder {
    func amountPaid(amountPaid: Amount) -> NewExpenseBuilder {
        return NewExpenseBuilder(event: event,
                                 amountPaid: amountPaid,
                              personWhoPaid: personWhoPaid,
                              peoplePaidFor: peoplePaidFor,
                              paidForDescription: paidForDescription)
    }
    
    func personWhoPaid(personWhoPaid: Person) -> NewExpenseBuilder {
        return NewExpenseBuilder(event: event, amountPaid: amountPaid,
                              personWhoPaid: personWhoPaid,
                              peoplePaidFor: peoplePaidFor,
                              paidForDescription: paidForDescription)
    }
    
    func peoplePaidFor(peoplePaidFor: [Person]) -> NewExpenseBuilder {
        return NewExpenseBuilder(event: event, amountPaid: amountPaid,
                              personWhoPaid: personWhoPaid,
                              peoplePaidFor: peoplePaidFor,
                              paidForDescription: paidForDescription)
    }
    
    func paidForDescription(paidForDescription: String) -> NewExpenseBuilder {
        return NewExpenseBuilder(event: event, amountPaid: amountPaid,
                              personWhoPaid: personWhoPaid,
                              peoplePaidFor: peoplePaidFor,
                              paidForDescription: paidForDescription)
    }
}
