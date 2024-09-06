//
//  AmountDetailViewView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 12/09/2023.
//

import Charts
import SwiftData
import SwiftUI

struct TotalDetailView: View {
    
    var account: Account
    
    @State private var listType: TransactionDisplayType = .all
    @State private var sortList: SortPayment = .standard
    
    private var paymentDataForView: [PaymentActivity] {
        switch sortList {
        case .standard:
            switch listType {
            case .all:
                return account.payments
                    .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})
                
            case .income:
                return account.payments
                    .filter { $0.type == .income }
                    .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})
                
            case .expense:
                return account.payments
                    .filter { $0.type == .expense }
                    .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})
                
            }
            
        case .inverse:
            switch listType {
            case .all:
                return account.payments
                    .sorted(by: {$0.date?.compare($1.date!) == .orderedAscending})
                
            case .income:
                return account.payments
                    .filter { $0.type == .income }
                    .sorted(by: {$0.date?.compare($1.date!) == .orderedAscending})
                
            case .expense:
                return account.payments
                    .filter { $0.type == .expense }
                    .sorted(by: {$0.date?.compare($1.date!) == .orderedAscending})
            }
        }
    }
    
    var body: some View {
        ScrollView {
            HeaderTotalDetailView(account: account)
            
            HistoricalChartView(payments: paymentDataForView)
            
            //MARK: LIST
            VStack(spacing: 0) {
                VStack(spacing: 2){
                    DetailMenu(sortList: $sortList)
                    
                    //MARK: Detail
                    AccountPaymentsSortingMenu(
                        listType: $listType,
                        sortList: $sortList
                    )
                }
                
                ForEach(paymentDataForView) {
                    PayementActivityCell(payment: $0)
                }
                .padding(.vertical, 3)
                
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 5)
        }
        .background(.backgroundColor5)
        .edgesIgnoringSafeArea(.top)
        
    }
}

//MARK: Preview
#Preview("Preview + Light", traits: .portrait, .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
        PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
        PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .now, type: .expense),
        PaymentActivity(name: "September Bonus", amount: 2200, date: .now, type: .income),
        PaymentActivity(name: "Basic balance", amount: 3000, date: .distantPast, type: .income)
    ], isFavorite: true, isMarked: false)
    container.mainContext.insert(account)
    
    return TotalDetailView(account: account)
        .modelContainer(container)
        .preferredColorScheme(.light)
}

#Preview("Preview + Dark", traits: .portrait, .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
        PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
        PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .now, type: .expense),
        PaymentActivity(name: "September Bonus", amount: 2200, date: .now, type: .income),
        PaymentActivity(name: "Basic balance", amount: 3000, date: .distantPast, type: .income)
    ], isFavorite: true, isMarked: false)
    container.mainContext.insert(account)
    
    return TotalDetailView(account: account)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}

private struct HeaderTotalDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var account: Account
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Total Balance")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                        .foregroundColor(.white)
                        .accessibilityAddTraits(.isHeader)
                        .padding(.top)
                    
                    Text("\(account.totalBalance, format: .localCurrency)")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .foregroundColor(.white)
                        .accessibilityAddTraits(.isHeader)
                    
                }
                .padding()
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding(.top)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 125)
        .background(.myGreen)
    }
}

private struct HistoricalChartView: View {
    
    var payments: [PaymentActivity]

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Overall History")
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
            }
            
            Chart(payments) {
                LineMark(
                    x: .value("Month", $0.date!),
                    y: .value("Amount", $0.amount)
                )
                .foregroundStyle(Color.myGreen)
                .symbol(Circle().strokeBorder(lineWidth: 2))
            }
        }
        .padding(.horizontal, 5)
    }
}

private struct DetailMenu: View {
    
    @Binding public var sortList: SortPayment
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Detail")
                .font(.system(.title, design: .rounded, weight: .bold))
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
            Menu {
                withAnimation(.interpolatingSpring) {
                    Picker("Sort", selection: $sortList) {
                        ForEach(SortPayment.allCases, id: \.self) { sort in
                            Label(sort.rawValue.capitalized, image: "tag")
                                .tag(sortList.rawValue)
                        }
                    }
                }
                .pickerStyle(.inline)
                
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(Color.accentColor)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel("Sorting parameter")
        }
    }
}

private struct AccountPaymentsSortingMenu: View {
    
    @Binding public var listType: TransactionDisplayType
    @Binding public var sortList: SortPayment
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                withAnimation(.bouncy) {
                    self.listType = .all
                }
            } label: {
                Text("All")
            }
            .buttonStyle(CustomButtonStyle(colorButton: .myGreen, descriptionForVO: "Press to select all transactions."))
            
            Button {
                withAnimation(.bouncy) {
                    self.listType = .income
                }
            } label: {
                Text("Income")
            }
            .buttonStyle(CustomButtonStyle(colorButton: .complementary, descriptionForVO: "Press to select all incomes."))
            
            Button {
                withAnimation(.bouncy) {
                    self.listType = .expense
                }
            } label: {
                Text("Expense")
            }
            .buttonStyle(CustomButtonStyle(colorButton: .red, descriptionForVO: "Press to select all expenses."))
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
