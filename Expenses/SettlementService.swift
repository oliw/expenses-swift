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
    
    func getRecommendations(for event: Event) -> [SettlementRecommendation] {
        let people = event.getPeople().sorted(by: { $0.name! > $1.name! })
        let expenses = event.getExpenses().sorted(by: { $0.getDate() > $1.getDate() })
        let paybacks = event.getPaybacks().sorted(by: { $0.getDate() > $1.getDate() })
        
        // init balance sheet
        let balanceSheet = BalanceSheet(people: people)

        // fill balance sheet
        for expense in expenses {
            let payer = expense.payer!
            let paidAmount = expense.amount
            balanceSheet.add(amount: paidAmount,to: payer)
            
            for participant in expense.participants! {
                let owedAmount = expense.amountOwed(by: participant)
                balanceSheet.remove(amount: owedAmount, from: participant)
            }
        }
        for payback in paybacks {
            let payer = payback.sender!
            let receiver = payback.receiver!
            let paidAmount = payback.getAmount()
            balanceSheet.add(amount: paidAmount, to: payer)
            balanceSheet.remove(amount: paidAmount, from: receiver)
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
            balanceSheet.remove(amount: amountToPay, from: richest.person)
            balanceSheet.add(amount: amountToPay, to: poorest.person)
        }
        
        return recommendations
    }
    
    fileprivate class BalanceSheet {
        var amounts: [Amount]
        var people: [Person]
        
        init(people:[Person]) {
            self.amounts = [Amount](repeating: Amount.zero(), count: people.count)
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
        
        func add(amount:Amount,to person:Person) {
            let index = self.people.index(of: person)!
            amounts[index] = amounts[index] + amount
        }
        
        func remove(amount:Amount,from person:Person) {
            let index = self.people.index(of: person)!
            amounts[index] = amounts[index] - amount
        }
    }

    struct BalanceSheetEntry {
        let person: Person
        let amount: Amount
    }
}
