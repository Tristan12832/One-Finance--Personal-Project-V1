//
//  Account.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import Foundation

class Account: Identifiable, ObservableObject {
    var id = UUID()
    @Published var name: String = ""
    @Published var icon: String = ""
    @Published var payements = [PayementActivity]()
    @Published var isFavorite: Bool
    @Published var isMarked: Bool
    
    var totalIncome: Double {
        let total = payements
            .filter {
                $0.type == .income
            }.reduce(0) {
                $0 + $1.amount
            }
        
        return total
    }
    
    var totalExpense: Double {
        let total = payements
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
    
    
    init(id: UUID = UUID(), name: String, icon: String, payements: [PayementActivity] = [PayementActivity](), isFavorite: Bool, isMarked: Bool) {
        self.id = id
        self.name = name
        self.icon = icon
        self.payements = payements
        self.isFavorite = isFavorite
        self.isMarked = isMarked
    }
}
