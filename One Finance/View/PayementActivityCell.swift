//
//  PayementActivityCell.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftData
import SwiftUI

struct PayementActivityCell: View {
    
    let payment: PaymentActivity
        
    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Image(systemName: payment.icon)
                Text(payment.name)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: 250, alignment: .leading)
            .foregroundStyle(payment.color)
            
            Spacer()
            
            HStack() {
                Text(payment.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")
                    .lineLimit(1)
                    .font(.system(.subheadline, weight: .semibold))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 5)
                    .frame(width: 120)
                    .frame(maxWidth: 140)
                    .frame(height: 40)
                    .background(.backgroundColor5, in: .rect(cornerRadius: 8))
                    .padding(.horizontal, 2)
                
                Text(payment.amount, format: .localCurrency)
                    .lineLimit(1)
                    .frame(width: 100)
                    .frame(alignment: .trailing)
                    .padding(.horizontal, 2)
                
            }
            .frame(width: 200, alignment: .trailing)
            .fixedSize(horizontal: true, vertical: true)
            
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .padding(2)
        .padding(.vertical, 4)
        .background(.backgroundColor4, in: .rect(cornerRadius: 8))
        .padding(4)
        .background(.backgroundColor3, in: .rect(cornerRadius: 8))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Transaction \(payment.name), \(payment.amount), \(payment.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")")
    }
}

#Preview("Light") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: PaymentActivity.self, configurations: config)
    let payment = PaymentActivity(name: "MacBook Pro 16 M2 Max", amount: 3700, date: .now, type: .income)
    container.mainContext.insert(payment)

    return PayementActivityCell(payment: payment)
        .modelContainer(container)
        .padding(5)
}

#Preview("Dark") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: PaymentActivity.self, configurations: config)
    let payment = PaymentActivity(name: "MacBook Pro 16 M2 Max", amount: 3700, date: .now, type: .income)
    container.mainContext.insert(payment)

     return PayementActivityCell(payment: payment)
        .modelContainer(container)
        .padding(5)
        .preferredColorScheme(.dark)
}
