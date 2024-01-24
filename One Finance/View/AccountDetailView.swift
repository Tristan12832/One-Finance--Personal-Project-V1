//
//  AccountDetailView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 30/08/2023.
//

import SwiftData
import SwiftUI

enum monthly: String, CaseIterable {
    case january, february, march, april, may, june, july, august, september, october, november, december, all
}

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
    //Allows you to update the payment table, otherwise the state of change is not communicated to other views.
    @Query var payments: [PaymentActivity]
    
    @State private var showingTotalDetailView = false
    @State private var shwoingIncomeDetailView = false
    @State private var shwoingExpenseDetailView = false
    
    @State private var shwoingNewPaymentActivity = false
    
    @State private var inversePayments = false
    @State private var inverseAction = false
    
    @State private var listType: TransactionDisplayType = .all
    @State private var sortList: sortPayment = .standard
    @State private var sortMonth: monthly = .all
    
    
    let paddingHorizontal: CGFloat = 20
    
    var paymentDataForView: [PaymentActivity] {
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
            withAnimation {
                let payment = paymentDataForView[index]
                modelContext.delete(payment)
            }
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text(account.name)
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .accessibilityAddTraits(.isHeader)
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
            
            
            //MARK: Futur - Add a date selector
            
            //MARK: LIST
            VStack(spacing: 0) {
                VStack(spacing: 2){
                    HStack(alignment: .center) {
                        Text("Detail")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .accessibilityAddTraits(.isHeader)
                        
                        Spacer()
                        
                        Menu {
                            withAnimation(.interpolatingSpring) {
                                Picker("Sort", selection: $sortList) {
                                    ForEach(sortPayment.allCases, id: \.self) { sort in
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
                    
                    
                    //MARK: Detail
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
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                List {
                    if paymentDataForView.isEmpty {
                        ContentUnavailableView("No Payments", systemImage: "banknote")
                            .padding(.vertical)
                            .listRowBackground(Color.backgroundColor5)
                    } else {
                        ForEach(paymentDataForView.indices, id: \.self) { index in
                            PayementActivityCell(icon: paymentDataForView[index].icon, nameActivity: paymentDataForView[index].name, amount: paymentDataForView[index].amount, date: paymentDataForView[index].date, textColor: paymentDataForView[index].color)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deletePayments)
                        .listRowInsets(EdgeInsets(top: 0, leading: 14, bottom: 6, trailing: 0))
                        .fixedSize(horizontal: false, vertical: true)
                        .listRowBackground(Color.backgroundColor5)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.backgroundColor5)
                .scrollIndicators(.never)
            }
            .background(.backgroundColor5)
            
            .fullScreenCover(isPresented: $showingTotalDetailView, content: {
                withAnimation(.snappy) {
                    TotalDetailView(account: account)
                }
            })
            .fullScreenCover(isPresented: $shwoingIncomeDetailView, content: {
                withAnimation(.snappy) {
                    IncomeDetailView(account: account)
                }
            })
            .fullScreenCover(isPresented: $shwoingExpenseDetailView, content: {
                withAnimation(.snappy) {
                    ExpenseDetailView(account: account)
                }
            })
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        shwoingNewPaymentActivity = true
                    } label: {
                        Label("Add a new transaction", systemImage: "plus")
                    }
                    .accessibilityHint("Press to add a new transaction to your account.")
                }
                
            }
            .fullScreenCover(isPresented: $shwoingNewPaymentActivity) {
                withAnimation(.snappy) {
                    NewPaymentActivity(account: account)
                }
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
    
    return NavigationStack {
        AccountDetailView(account: account)
    }
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
    
    return NavigationStack {
        AccountDetailView(account: account)
    }
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
