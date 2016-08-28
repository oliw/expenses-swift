//
//  SettlementService.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/28/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import Foundation

class SettlementService {

    class var sharedInstance: SettlementService {
        struct Singleton {
            static let instance = SettlementService()
        }
        return Singleton.instance
    }
    
    func getRecommendations(event: Event) -> [SettlementRecommendation] {
        let expenses = event.getExpenses()
        let people = event.getPeople()
        
        // init balance sheet
        let balanceSheet = BalanceSheet(people: people)

        // fill balance sheet
        for expense in expenses {
            let payer = expense.payer!
            let paidAmount = expense.getAmount()
            balanceSheet.addAmountToPerson(paidAmount, person: payer)
            
            for participant in expense.getParticipants() {
                let owedAmount = expense.getAmountOwedFor(participant)
                balanceSheet.decrAmountFromPerson(owedAmount, person: participant)
            }
        }
        
        // create recommendations
        var recommendations:[SettlementRecommendation] = []
        while !(balanceSheet.zeroed()) {
            let richest = balanceSheet.richest()
            let poorest = balanceSheet.poorest()
            var amountToPay = Amount.zero()
            if abs(richest.amount) >= abs(poorest.amount) {
                // e.g. richest +10
                // e.g. poorest -5
                amountToPay = abs(poorest.amount)

            } else {
                // e.g. richest +4
                // e.g. poorest -10
                amountToPay = richest.amount
            }
            let recommendation = SettlementRecommendation(from: poorest.person, to: richest.person, amount: amountToPay)
            recommendations.append(recommendation)
            balanceSheet.decrAmountFromPerson(amountToPay, person: richest.person)
            balanceSheet.addAmountToPerson(amountToPay, person: poorest.person)
        }
        
        return recommendations
    }
    
    private class BalanceSheet {
        var amounts: [Amount]
        var people: [Person]
        
        init(people:[Person]) {
            self.amounts = [Amount](count: people.count, repeatedValue: Amount.zero())
            self.people = people
        }
        
        func zeroed() -> Bool {
            for i in 0 ..< self.amounts.count {
                if !self.amounts[i].isZero() {
                    return false
                }
            }
            return true
        }
        
        func richest() -> BalanceSheetEntry {
            var index = 0
            var biggestPerson = people[index]
            var biggestAmount = amounts[index]
            for i in 0 ..< self.amounts.count {
                if (amounts[i] > biggestAmount) {
                    index = i
                    biggestPerson = people[i]
                    biggestAmount = amounts[i]
                }
            }
            return BalanceSheetEntry(person: biggestPerson, amount: biggestAmount)
        }
        
        func poorest() -> BalanceSheetEntry {
            var index = 0
            var smallestPerson = people[index]
            var smallestAmount = amounts[index]
            for i in 0 ..< self.amounts.count {
                if (amounts[i] < smallestAmount) {
                    index = i
                    smallestPerson = people[i]
                    smallestAmount = amounts[i]
                }
            }
            return BalanceSheetEntry(person: smallestPerson, amount: smallestAmount)
        }
        
        func addAmountToPerson(amount:Amount, person:Person) {
            let index = self.people.indexOf(person)!
            amounts[index] = amounts[index] + amount
        }
        
        func decrAmountFromPerson(amount:Amount, person:Person) {
            let index = self.people.indexOf(person)!
            amounts[index] = amounts[index] - amount
        }
    }

    struct BalanceSheetEntry {
        let person: Person
        let amount: Amount
    }
}