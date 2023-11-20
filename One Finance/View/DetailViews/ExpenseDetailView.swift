//
//  ExpenseDetailView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 15/09/2023.
//

import Charts
import SwiftData
import SwiftUI

enum sortExpense {
    case standard
    case inverse
}
struct ExpenseDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var account: Account
    
    @State private var sortList: sortPayment = .standard

    private var paymentExpense: [PaymentActivity] {
        switch sortList {
        case .standard:
            return account.payments
                .filter { $0.type == .expense }
                .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})
        case .inverse:
            return account.payments
                .filter { $0.type == .expense }
                .sorted(by: {$0.date?.compare($1.date!) == .orderedAscending})
        }
       

    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Expenses")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        Text("\(account.totalBalance, format: .localCurrency)")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
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
            .background(.red)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Overall History")
                        .font(.system(.title, design: .rounded, weight: .bold))
                    Spacer()
                }
                //MARK: CHART
                ///GRAPHIQUE ICI!!!!
                Chart(paymentExpense) {
                    LineMark(
                        x: .value("Month", $0.date!),
                        y: .value("Amount", $0.amount)
                    )
                    .foregroundStyle(Color.red)
                    .symbol(Circle().strokeBorder(lineWidth: 2))

                }
                
            }
            .padding(.horizontal, 5)
            
            
            //MARK: LIST
            VStack(spacing: 0) {
                VStack(spacing: 2){
                    HStack(alignment: .center) {
                        Text("Detail")
                            .font(.system(.title, design: .rounded, weight: .bold))
                        Spacer()
                        
                        Menu {
                            Picker("Sort", selection: $sortList) {
                                ForEach(sortPayment.allCases, id: \.self) { sort in
                                    Label(sort.rawValue.capitalized, image: "tag")
                                        .tag(sortList.rawValue)

                                }
                            }
                            .pickerStyle(.inline)
                          
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.system(.title2, design: .rounded, weight: .bold))
                                .foregroundColor(Color.red)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Sorting parameter")                    }
                    .padding(.vertical, 4)
                }
                
                ForEach(paymentExpense.indices, id: \.self) { index in
                    PayementActivityCell(icon: paymentExpense[index].icon, nameActivity: paymentExpense[index].name, amount: paymentExpense[index].amount, date: paymentExpense[index].date)
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
    
    return ExpenseDetailView(account: account)
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
    
    return ExpenseDetailView(account: account)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
