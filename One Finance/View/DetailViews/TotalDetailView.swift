//
//  AmountDetailViewView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 12/09/2023.
//

import Charts
import SwiftUI

//MARK: TransactionDisplayType is enum for selection the transaction type
enum TransactionDisplayType_TotalDetailView {
    case all
    case income
    case expense
}

struct TotalDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var model: Account
    
    @State private var listType: TransactionDisplayType_TotalDetailView = .all
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
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Total Balance")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        Text("\(model.totalBalance, format: .localCurrency)")
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
            .background(.myGreen)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Overall History")
                        .font(.system(.title, design: .rounded, weight: .bold))
                    Spacer()
                }
                //MARK: CHART
                ///GRAPHIQUE ICI!!!!
                Chart(paymentDataForView) {
                    LineMark(
                        x: .value("Month", $0.date!),
                        y: .value("Amount", $0.amount)
                    )
                    .foregroundStyle(Color.myGreen)
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

struct TotalDetailView_Previews: PreviewProvider {
    
    ///init the "Preview" to display
    struct Preview: View {
        @StateObject private var model =  Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
            PaymentActivity(name: "Salery", amount: 2000, date: .distantPast, type: .income),
            PaymentActivity(name: "September Bonus", amount: 200, date: .now, type: .income),
            PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
            PaymentActivity(name: "Food", amount: 500, date: .distantFuture, type: .expense),
            PaymentActivity(name: "Feed", amount: 200, date: .distantFuture, type: .expense)

        ], isFavorite: true, isMarked: false)
        var body: some View {
            TotalDetailView(model: model)
        }
    }
    static var previews: some View {
        Preview()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
