//
//  AccountDetailView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 30/08/2023.
//

import SwiftUI

//MARK: AccountCellView
///Below are the components:
/// - AmountView component

enum TransactionDisplayType {
    case all
    case income
    case expense
}

struct AccountDetailView: View {
    
    @ObservedObject var model: Account
    
    @State private var listType: TransactionDisplayType = .all
    @State private var selectedPaymentActivity: PaymentActivity?


    private var paymentDataForView: [PaymentActivity] {
        switch listType {
        case .all:
            return model.payments
                .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})
        case .income:
            return model.payments
                .filter { $0.type == .income }
                .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})

        case .expense:
            return model.payments
                .filter { $0.type == .expense }
                .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})

        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Text(model.name)
                    .font(.system(size: 40, weight: .bold, design: .default))
                .padding(.horizontal, 30)
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                AmountView(title: "Total Account", amount: model.totalBalance, backgroundColor: .myGreenApple_light)
                
                HStack(spacing: 16){
                    AmountView(title: "Income", amount: model.totalIncome, backgroundColor: .complementaryColor_light)
                    AmountView(title: "Expense", amount: model.totalExpense, backgroundColor: .red)
                }
            }
            .padding(.horizontal, 30)
            .fixedSize(horizontal: false, vertical: true)
            
            //MARK: LIST
            VStack(spacing: 0) {
                VStack(spacing: 2){
                    HStack(alignment: .center) {
                        Text("Detail")
                            .font(.system(.title, design: .rounded, weight: .bold))
                        Spacer()
                        Button {
                            //MARK: FUTUR
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.system(.title3, design: .rounded, weight: .bold))
                                .foregroundColor(.myGreenApple_light)
                        }


                    }
                    //MARK: Detail
                    HStack(alignment: .top) {
                        Group {
                            Text("All")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(.myGreenApple_light)
                                .onTapGesture {
                                    self.listType = .all
                                }
                            Text("Income")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(.complementaryColor_light)
                                .onTapGesture {
                                    self.listType = .income
                                }
                            Text("Expense")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .onTapGesture {
                                    self.listType = .expense
                                }
                        }
                        .font(.system(.headline, design: .rounded))
                        .cornerRadius(8)
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                
                ForEach(paymentDataForView.indices, id: \.self) { index in
                    PayementActivityCell(icon: paymentDataForView[index].icon, nameActivity: paymentDataForView[index].name, amount: paymentDataForView[index].amount, date: paymentDataForView[index].date)
                }
                .padding(1)
             }
            .padding(.vertical, 30)
            .padding(.horizontal, 30)
        }
        .toolbarBackground(Color.lightBackground5)
        .background(.lightBackground5)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    //more action
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(.title2))

                }

            }
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                   //more action
                } label: {
                    Image(systemName: "plus")
                        .font(.system(.title2))
                }

            }

        }
        
    }
}

//MARK: Preview
struct HeaderAccountView_Previews: PreviewProvider {
    
    ///init the "Preview" to display 
    struct Preview: View {
        @StateObject private var model =  Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
            PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
            PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .now, type: .expense),
            PaymentActivity(name: "September Bonus", amount: 2200, date: .now, type: .income),
            PaymentActivity(name: "Basic balance", amount: 3000, date: .distantPast, type: .income)
        ], isFavorite: true, isMarked: false)
        var body: some View {
            AccountDetailView(model: model)
        }
    }
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationStack {
            Preview()
        }
        .previewDisplayName("Preview Standard")
        .previewInterfaceOrientation(.portrait)
        .tint(.myGreenApple_light)
        
        NavigationSplitView {
            SidebarPreview()
        } detail: {
            Preview()
                .background(.lightBackground5)
        }
        .previewInterfaceOrientation(.landscapeRight)
        .previewDevice("iPad Air (5th generation)")
        
       
    }
}

