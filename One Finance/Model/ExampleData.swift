//
//  ExampleData.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import Foundation
import SwiftUI

class ExampleAccounts: ObservableObject {
    @Published var example_Accounts: [Account] = [
        Account(id: UUID(), name: "Future expenditure", icon: "creditcard.fill", payments: [
            PaymentActivity(name: "MacBook Pro 16 M2 Max", amount: 4000, date: .distantFuture, type: .expense),
            PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .distantFuture, type: .expense),
            PaymentActivity(name: "September Bonus", amount: 2200, date: .distantFuture, type: .income),
            PaymentActivity(name: "Basic balance", amount: 3000, date: .distantFuture, type: .income)
        ], isFavorite: true, isMarked: false),
        
        Account(id: UUID(), name: "Current account", icon: "house.fill", payments: [
            PaymentActivity(name: "September salary", amount: 2400, date: .now, type: .income),
            PaymentActivity(name: "Allocation", amount: 250, date: .now, type: .income),
            PaymentActivity(name: "Food", amount: 100, date: .now, type: .expense),
            PaymentActivity(name: "Clothing", amount: 50, date: .now, type: .expense),
            PaymentActivity(name: "Dog budget", amount: 120, date: .now, type: .expense)
        ], isFavorite: false, isMarked: false),
        
        Account(id: UUID(), name: "Savings account Tristan", icon: "banknote.fill", payments: [
            PaymentActivity(name: "Base amount", amount: 6000, date: .now, type: .income)
        ], isFavorite: true, isMarked: false),
        
        Account(id: UUID(), name: "Current account Zoé", icon: "house.fill", payments: [
            PaymentActivity(name: "September salary", amount: 1200, date: .now, type: .income),
            PaymentActivity(name: "Allocation", amount: 120, date: .now, type: .income),
            PaymentActivity(name: "Clothing", amount: 120, date: .now, type: .expense),
            PaymentActivity(name: "Danse budget", amount: 120, date: .now, type: .expense)
        ], isFavorite: false, isMarked: true),
        
        Account(id: UUID(), name: "Savings account Zoé", icon: "banknote.fill", payments: [
            PaymentActivity(name: "Base amount", amount: 10000, date: .now, type: .income),
            PaymentActivity(name: "MacBook Air 15", amount: 2100, date: .now, type: .expense)
        ], isFavorite: true, isMarked: true)
    ]
    
    var isFavoriteFilter: [Account] {
        get {return example_Accounts.filter{ $0.isFavorite }}
        set { example_Accounts = example_Accounts.filter{ $0.isFavorite }
            objectWillChange.send()
        }
    }
    
    var isMarkedFilter: [Account] {
        get {return example_Accounts.filter{ $0.isMarked }}
        set { example_Accounts = example_Accounts.filter{ $0.isMarked }
            objectWillChange.send()
        }
    }
 
}
