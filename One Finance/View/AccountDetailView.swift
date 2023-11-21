//
//  AccountDetailView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 30/08/2023.
//

import SwiftData
import SwiftUI

//MARK: TransactionDisplayType is enum for selection the transaction type
enum TransactionDisplayType {
    case all
    case income
    case expense
}

enum sortPayment: String, CaseIterable {
    case standard
    case inverse
}

//MARK: AccountCellView
struct AccountDetailView: View {
    @Environment(\.modelContext) var modelContext
    
    var account: Account

    @State private var showingTotalDetailView = false
    @State private var shwoingIncomeDetailView = false
    @State private var shwoingExpenseDetailView = false
    
    @State private var shwoingNewPaymentActivity = false
    
    @State private var inversePayments = false
    @State private var inverseAction = false
    
    @State private var listType: TransactionDisplayType = .all
    @State private var sortList: sortPayment = .standard
    
    let paddingHorizontal: CGFloat = 20

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
    
    
    func deletePayments(_ indexSet: IndexSet){
        for index in indexSet {
            let payment = paymentDataForView[index]
            modelContext.delete(payment)
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text(account.name)
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .padding(.horizontal, paddingHorizontal)
                
                Spacer()
            }

            VStack(spacing: 16) {
                AmountView(title: "Total Account", amount: account.totalBalance, backgroundColor: .myGreen)
                    .onTapGesture {
                        self.showingTotalDetailView = true
                    }
                HStack(spacing: 16){
                    AmountView(title: "Income", amount: account.totalIncome, backgroundColor: .complementary)
                        .onTapGesture {
                            self.shwoingIncomeDetailView = true
                        }
                    AmountView(title: "Expense", amount: account.totalExpense, backgroundColor: .red)
                        .onTapGesture {
                            self.shwoingExpenseDetailView = true
                        }
                }
            }
            .padding(.horizontal, paddingHorizontal)
            .fixedSize(horizontal: false, vertical: true)
            
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
                                .foregroundColor(Color.accentColor)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Sorting parameter")

                    }
                    //MARK: Detail
                    HStack(alignment: .top) {
                        Button {
                            self.listType = .all
                        } label: {
                            Text("All")
                        }
                        .buttonStyle(CustomButtonStyle(colorButton: .myGreen))
                        
                        Button {
                            self.listType = .income
                        } label: {
                            Text("Income")
                        }
                        .buttonStyle(CustomButtonStyle(colorButton: .complementary))
                        
                        Button {
                            self.listType = .expense
                        } label: {
                            Text("Expense")
                        }
                        .buttonStyle(CustomButtonStyle(colorButton: .red))
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                List {
                    if paymentDataForView.isEmpty {
                        ContentUnavailableView("No Payments", systemImage: "banknote")
                            .padding(.vertical)
                            .listRowBackground(Color.backgroundColor5)
                    } else {
                        ForEach(paymentDataForView.indices, id: \.self) { index in
                            PayementActivityCell(icon: paymentDataForView[index].icon, nameActivity: paymentDataForView[index].name, amount: paymentDataForView[index].amount, date: paymentDataForView[index].date)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deletePayments)
                        .fixedSize(horizontal: false, vertical: true)
                        .listRowBackground(Color.backgroundColor5)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.backgroundColor5)
            }
            .background(.backgroundColor5)
            
            .fullScreenCover(isPresented: $showingTotalDetailView, content: {
                TotalDetailView(account: account)
            })
            .fullScreenCover(isPresented: $shwoingIncomeDetailView, content: {
                IncomeDetailView(account: account)
            })
            .fullScreenCover(isPresented: $shwoingExpenseDetailView, content: {
                ExpenseDetailView(account: account)
            })
            .toolbar {                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        shwoingNewPaymentActivity = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(.title2))
                    }
                    .accessibilityLabel("Add")
                    .accessibilityHint("Add a new transaction")
                }
                
            }
            .fullScreenCover(isPresented: $shwoingNewPaymentActivity) {
                NewPaymentActivity(account: account)
            }

        }
        .toolbarBackground(Color.backgroundColor5)
        .background(.backgroundColor5)
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
    
    return AccountDetailView(account: account)
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
    
    return AccountDetailView(account: account)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}

#Preview("Preview + Sidebar + Light", traits: .landscapeRight, .sizeThatFitsLayout) {
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
        PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
        PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .now, type: .expense),
        PaymentActivity(name: "September Bonus", amount: 2200, date: .now, type: .income),
        PaymentActivity(name: "Basic balance", amount: 3000, date: .distantPast, type: .income)
    ], isFavorite: true, isMarked: false)
    container.mainContext.insert(account)
    
    return NavigationSplitView(sidebar: {
        SidebarPreview()
    }, detail: {
        AccountDetailView(account: account)
    })
    .modelContainer(container)
    .preferredColorScheme(.light)
}

#Preview("Preview + Sidebar + Dark", traits: .landscapeRight, .sizeThatFitsLayout) {
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
        PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
        PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .now, type: .expense),
        PaymentActivity(name: "September Bonus", amount: 2200, date: .now, type: .income),
        PaymentActivity(name: "Basic balance", amount: 3000, date: .distantPast, type: .income)
    ], isFavorite: true, isMarked: false)
    container.mainContext.insert(account)
    
    return NavigationSplitView(sidebar: {
        SidebarPreview()
    }, detail: {
        AccountDetailView(account: account)
    })
    .modelContainer(container)
    .preferredColorScheme(.dark)
}
