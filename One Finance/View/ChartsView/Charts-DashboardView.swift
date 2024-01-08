//
//  ChartsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 20/11/2023.
//

import Charts
import SwiftData
import SwiftUI

struct ChartsView: View {
    
    @Query(animation: .default) var accounts: [Account]
    
    var accountsData: [Account] {
        accounts.sorted(by: {$0.totalBalance < $1.totalBalance})
    }
    
    var totalExpensesAndIncome: Double {
        let totals = accounts
            .sorted(by: {$0.totalBalance < $1.totalBalance})
            .reduce(0) { $0 + $1.totalBalance }
        return totals
    }
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Total Money")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                Spacer()
                
                Text(totalExpensesAndIncome, format: .localCurrency)
                    .font(.headline)
                    .frame(width: 90)
                    .frame(maxWidth: 90, alignment: .trailing)
                    .padding(.horizontal, 2)
                    .background(.backgroundColor3)
                
            }
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isHeader)
            .accessibilityLabel("Your Total Money, \(totalExpensesAndIncome, format: .localCurrency)")
            
            Chart {
                ForEach(accountsData, id: \.name) { account in
                    
                    BarMark(
                        x: .value("Your total of the accounts", account.totalBalance),
                        y: .value("Names your accounts", account.name)
                    )
                    .foregroundStyle(by: .value("Name", account.name))
                    
                }
                
            }
            .frame(height: 100)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isSummaryElement)
            
        }
        .padding()
        .frame(maxWidth: 500)
        .background(.backgroundColor4)
        
    }
}

struct DonutChartView: View {
    
    @Query(animation: .default) var accounts: [Account]
    
    var accountsData: [Account] {
        accounts.sorted(by: {$0.totalBalance < $1.totalBalance})
    }
    
    var totalExpensesAndIncome: Double {
        let totals = accounts
            .sorted(by: {$0.totalBalance < $1.totalBalance})
            .reduce(0) { $0 + $1.totalBalance }
        return totals
    }
    
    func percenageForChart(account: Double) -> Double {
        let numberAccount = totalExpensesAndIncome
        return account/numberAccount
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Percentage by account")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                Spacer()
            }
            .accessibilityAddTraits(.isHeader)
            
            Chart {
                ForEach(accountsData, id: \.name) { account in
                    
                    SectorMark(
                        angle: .value("Your total of the accounts", account.totalBalance), innerRadius: .ratio(0.65),
                        angularInset: 2.0
                        
                    )
                    .foregroundStyle(by: .value("Name", account.name))
                    .annotation(position: .overlay) {
                        Text("\(String(format: "%.2f", (percenageForChart(account: account.totalBalance))*100)) %")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    .accessibilityLabel(accountsData.count > 0 ? "You have \(accountsData.count) account(s). Your account \(account.name) representable \(String(format: "%.2f", (percenageForChart(account: account.totalBalance))*100)) of the \(account.totalBalance)" : "You don't have an account yet.")
                }
                
            }
            .frame(height: 250)
            .accessibilityAddTraits(.isSummaryElement)
            
        }
        .padding()
        .frame(maxWidth: 500)
        .background(.backgroundColor4)
    }
}
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    for _ in 0..<3 {
        let account = Account(name: "Current account", icon: "house.fill", payments: [
            PaymentActivity(name: "September salary", amount: 2400, date: .now, type: .income),
            PaymentActivity(name: "Allocation", amount: 250, date: .now, type: .income),
            PaymentActivity(name: "Food", amount: 100, date: .now, type: .expense),
            PaymentActivity(name: "Clothing", amount: 50, date: .now, type: .expense),
            PaymentActivity(name: "Dog budget", amount: 120, date: .now, type: .expense)
        ], isFavorite: false, isMarked: false)
        container.mainContext.insert(account)
    }
    
    return DonutChartView()
        .modelContainer(container)
        .preferredColorScheme(.light)
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    
    for _ in 0..<3 {
        let account = Account(name: "Current account", icon: "house.fill", payments: [
            PaymentActivity(name: "September salary", amount: 2400, date: .now, type: .income),
            PaymentActivity(name: "Allocation", amount: 250, date: .now, type: .income),
            PaymentActivity(name: "Food", amount: 100, date: .now, type: .expense),
            PaymentActivity(name: "Clothing", amount: 50, date: .now, type: .expense),
            PaymentActivity(name: "Dog budget", amount: 120, date: .now, type: .expense)
        ], isFavorite: false, isMarked: false)
        container.mainContext.insert(account)
    }
    
    return DonutChartView()
        .modelContainer(container)
        .preferredColorScheme(.light)
    
}
