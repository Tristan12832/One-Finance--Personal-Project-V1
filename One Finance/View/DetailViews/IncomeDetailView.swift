//
//  IncomeDetailView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 15/09/2023.
//

import Charts
import SwiftUI

//MARK: TransactionDisplayType is enum for selection the transaction type

struct IncomeDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var account: Account
    
    private var paymentIncome: [PaymentActivity] {
        return account.payments
            .filter { $0.type == .income }
            .sorted(by: {$0.date?.compare($1.date!) == .orderedDescending})

    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Incomes")
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
            .background(.complementary)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Overall History")
                        .font(.system(.title, design: .rounded, weight: .bold))
                    Spacer()
                }
                //MARK: CHART
                ///GRAPHIQUE ICI!!!!
                Chart(paymentIncome) {
                    LineMark(
                        x: .value("Month", $0.date!),
                        y: .value("Amount", $0.amount)
                    )
                    .foregroundStyle(Color.complementary)
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
                                .foregroundColor(Color.complementary)
                        }
                        
                        
                    }
                }
                
                ForEach(paymentIncome.indices, id: \.self) { index in
                    PayementActivityCell(icon: paymentIncome[index].icon, nameActivity: paymentIncome[index].name, amount: paymentIncome[index].amount, date: paymentIncome[index].date)
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

struct IncomeDetailView_Previews: PreviewProvider {
    
    ///init the "Preview" to display
    struct Preview: View {
        @State private var account =  Account(name: "Future expenditure", icon: "creditcard.fill", payments: [
            PaymentActivity(name: "Salery", amount: 2000, date: .distantPast, type: .income),
            PaymentActivity(name: "September Bonus", amount: 200, date: .now, type: .income),
            PaymentActivity(name: "MacBook Pro 16", amount: 4000, date: .now, type: .expense),
            PaymentActivity(name: "Food", amount: 500, date: .distantFuture, type: .expense),
            PaymentActivity(name: "Feed", amount: 200, date: .distantFuture, type: .expense)

        ], isFavorite: true, isMarked: false)
        var body: some View {
            IncomeDetailView(account: account)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
