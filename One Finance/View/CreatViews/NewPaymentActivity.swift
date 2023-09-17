//
//  NewPaymentActivity.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftUI

struct NewPaymentActivity: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var model: Account

    @State private var namePaymentActivity = ""
    @State private var amount = 0.0
    @State private var date = Date.now
    @State private var type: TypePayement = .expense
//    @State private var types = ["Income", "Expense"]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text(namePaymentActivity == "" ? "New Payment Activity" : namePaymentActivity)
                        TextField("Write... Ex: Curently Payment Activity", text: $namePaymentActivity)
                            .padding(8)
                            .background(colorScheme == .light ? .white : .black)
                            .cornerRadius(8)
                    }
                    .font(.system(.title3, weight: .semibold))

                                        
                    VStack(alignment: .leading) {
                        Text("Amount")
                        TextField("00", value: $amount, format: .localCurrency)
                            .keyboardType(.numberPad)
                            .padding(8)
                            .background(colorScheme == .light ? .white : .black)
                            .cornerRadius(8)
                    }
                    .font(.system(.title3, weight: .semibold))

                    VStack(alignment: .leading) {
                        Text("Type Payment Activity")
                        Picker("Type", selection: $type) {
                            ForEach(TypePayement.allCases, id: \.self) { item in
                                Text(item.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(8)
                        .background(colorScheme == .light ? .white : .black)
                        .cornerRadius(8)
                    }
                    .font(.system(.title3, weight: .semibold))
                    
                    VStack(alignment: .leading) {
                        DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                               Text("Select a date")
                           }
                        .pickerStyle(.segmented)
                        .padding(8)
                        .background(colorScheme == .light ? .white : .black)
                        .cornerRadius(8)
                    }
                    .font(.system(.title3, weight: .semibold))

                    //BUTTON HERE
                    Spacer(minLength: 25)
                    MainCustomButton(title: "Creat !") {
                        let newPaymentActivity = PaymentActivity(name: namePaymentActivity, amount: amount, date: date, type: type)
                        model.payments.append(newPaymentActivity)
                        dismiss()
                    }
                }
                .padding(.horizontal, 10)
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(Color.backgroundColor5)
            .background(.backgroundColor5)
            .navigationTitle("Creat account")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                            .padding()

                    }

                }
            }
        }    }
}

struct NewPaymentActivity_Previews: PreviewProvider {
    
    ///init the "Preview" to display
    struct Preview: View {
        @StateObject private var model = Accounts()
        var body: some View {
            NewPaymentActivity(model:  Account(name: "test", icon: "house.fil", isFavorite: false, isMarked: false))
        }
    }
    
    static var previews: some View {
        Preview()
        
    }
}
