//
//  Account.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import Foundation
import SwiftData


@Model class Account {
    let id = UUID()
    let name: String = ""
    let icon: String = ""
    @Relationship(deleteRule: .cascade, inverse: \PaymentActivity.account) var payments: [PaymentActivity]
    var isFavorite: Bool
    var isMarked: Bool

    init(name: String, icon: String, payments: [PaymentActivity], isFavorite: Bool, isMarked: Bool) {
        self.name = name
        self.icon = icon
        self.payments = []
        self.isFavorite = isFavorite
        self.isMarked = isMarked
    }
}

// Extension of the Account class to add computed properties
extension Account {
    
    /// This property is used to calculate the total cash inflow to the account.
    ///
    /// - Returns: Returns the total sum of income.
    var totalIncome: Double {
        let total = payments
            .filter {
                $0.type == .income
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    
    /// This calculated property is used to calculate the account's cash inflows.
    ///
    /// - Returns: Returns a sum of expenses.
    var totalExpense: Double {
        let total = payments
            .filter {
                $0.type == .expense
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    
    /// This property calculates the total amount of money available.
    ///
    /// - Returns: Returns the total amount of money in the account.
    var totalBalance: Double {
        return totalIncome - totalExpense
    }
}
