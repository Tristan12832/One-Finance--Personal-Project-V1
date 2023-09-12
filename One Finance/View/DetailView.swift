//
//  AmountDetailViewView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 12/09/2023.
//

import Charts
import SwiftUI

//MARK: TransactionDisplayType is enum for selection the transaction type
enum TransactionDisplayType_AmountDetailViewView {
    case all
    case income
    case expense
}

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var model: Account
    
    @State private var listType: TransactionDisplayType_AmountDetailViewView = .all
    @State private var selectedPaymentActivity: PaymentActivity?
    
    private var paymentDate: [PaymentActivity] {
        switch listType {
        case .all:
            return model.payments
        case .income:
            return model.payments
                .filter { $0.type == .income }
        case .expense:
            return model.payments
                .filter { $0.type == .expense }
        }
    }
    
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
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Balance")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
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
            .background(.myGreen)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Overall History")
                        .font(.system(.title, design: .rounded, weight: .bold))
                    Spacer()
                }
                ///GRAPHIQUE ICI!!!!
                Chart {
                    ForEach(model.payments, id: \.date) { item in
                        //                        LineMark(
                        //                            x: .value("Date", item.date!),
                        //                            y: .value("Balance", item.amount),
                        //                            series: .value("PaymentActivity", "all")
                        //                        )
                        LineMark(x: .value("Date", item.date!), y: .value("Amount", item.amount), series: .value("PaymentActivity", "all"))
                            .foregroundStyle(.myGreen)
                    }
                    //                    ForEach(model.payments, id: \.date) { item in
                    //                        LineMark(
                    //                            x: .value("Date", item.date!),
                    //                            y: .value("Income", item.amount),
                    //                            series: .value("PaymentActivity", "icome")
                    //                        )
                    //                        .foregroundStyle(.complementary)
                    //                    }
                    //                    ForEach(model.payments, id: \.date) { item in
                    //                        LineMark(x: .value("Date", item.date!), y: .value("Expense", item.amount),
                    //                            series: .value("PaymentActivity", "expense")
                    //
                    //                        )
                    //                        .foregroundStyle(.red)
                    //                    }
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
                        Button {
                            //MARK: FUTUR
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.system(.title3, design: .rounded, weight: .bold))
                                .foregroundColor(Color.myGreen)
                        }
                        
                        
                    }
                    
                    //MARK: Detail
                    HStack(alignment: .top) {
                        Group {
                            Text("All")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(Color.myGreen)
                                .onTapGesture {
                                    self.listType = .all
                                }
                            Text("Income")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(Color.complementary)
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
            .padding(.vertical, 15)
            .padding(.horizontal, 5)
        }
        .background(.backgroundColor5)
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    
    ///init the "Preview" to display
    struct Preview: View {
        @StateObject private var model =  Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
            PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .distantPast, type: .expense),
            PaymentActivity(name: "LG Ultrafine 27UQ850-W 4K Monitor", amount: 500, date: .now, type: .expense),
            PaymentActivity(name: "September Bonus", amount: 2200, date: .now, type: .income),
            PaymentActivity(name: "Basic balance", amount: 3000, date: .distantFuture, type: .income)
        ], isFavorite: true, isMarked: false)
        var body: some View {
            DetailView(model: model)
        }
    }
    static var previews: some View {
        Preview()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
