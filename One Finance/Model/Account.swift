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
    var name: String = ""
    var icon: String = ""
    @Relationship(deleteRule: .cascade) var payments = [PaymentActivity]()
    var isFavorite: Bool
    var isMarked: Bool

    var totalIncome: Double {
        let total = payments
            .filter {
                $0.type == .income
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    var totalExpense: Double {
        let total = payments
            .filter {
                $0.type == .expense
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    var totalBalance: Double {
        return totalIncome - totalExpense
    }
    
    
    init(name: String, icon: String, payments: [PaymentActivity] = [PaymentActivity](), isFavorite: Bool, isMarked: Bool) {
        self.name = name
        self.icon = icon
        self.payments = payments
        self.isFavorite = isFavorite
        self.isMarked = isMarked
    }
}
