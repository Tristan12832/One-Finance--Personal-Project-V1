//
//  NewPaymentActivity.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftData
import SwiftUI

struct NewPaymentActivity: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @Bindable var account: Account

    @State private var namePaymentActivity = ""
    @State private var amount = 0.0
    @State private var date = Date.now
    @State private var type: TypePayement = .expense

    let paddingHorizontal: CGFloat = 20
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Name of new payment activity")
                        TextField("Write... Ex: Curently Payment Activity", text: $namePaymentActivity)
                            .padding(8)
                            .background(colorScheme == .light ? .white : .black)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    .font(.system(.title3, weight: .semibold))
                    
                    
                    VStack(alignment: .leading) {
                        Text("Amount")
                        TextField("00", value: $amount, format: .localCurrency)
                            .keyboardType(.numberPad)
                            .padding(8)
                            .background(colorScheme == .light ? .white : .black)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    .font(.system(.title3, weight: .semibold))
                    
                    VStack(alignment: .leading) {
                        Text("Type Payment Activity")
                        Picker("Type", selection: $type) {
                            ForEach(TypePayement.allCases, id: \.self) { item in
                                Text(item.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(8)
                        .background(colorScheme == .light ? .white : .black)
                        .clipShape(.rect(cornerRadius: 8))
                    }
                    .font(.system(.title3, weight: .semibold))
                    
                    VStack(alignment: .leading) {
                        DatePicker(selection: $date, displayedComponents: [.date]) {
                            Text("Select a date")
                        }
                        .pickerStyle(.segmented)
                        .padding(8)
                        .background(colorScheme == .light ? .white : .black)
                        .clipShape(.rect(cornerRadius: 8))
                    }
                    .font(.system(.title3, weight: .semibold))
                    
                    //BUTTON HERE
                    Spacer(minLength: 25)
                    MainCustomButton(title: "Creat !") {
                        withAnimation(.default) {
                            let newPaymentActivity = PaymentActivity(name: namePaymentActivity, amount: amount, date: date, type: type)
                            account.payments.append(newPaymentActivity)
                            dismiss()
                        }
                    }
                }
                .padding(.horizontal, paddingHorizontal)
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(Color.backgroundColor5)
            .background(.backgroundColor5)
            .navigationTitle("New transaction")
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
        }
    }
}

#Preview("Preview") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Account.self, configurations: config)
        
        let example = Account(name: "Test", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
        
        return NewPaymentActivity(account: example)
            .modelContainer(container)
            .preferredColorScheme(.dark)
        
    } catch {
        fatalError("Failed to create model container.")
    }
}

