//
//  PayementActivityCell.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftUI

struct PayementActivityCell: View {

    var icon: String
    var nameActivity: String
    var amount: Double
    var date: Date?
    var textColor: Color
    
    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                Text(nameActivity)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: 250, alignment: .leading)
            .foregroundStyle(textColor)
            Spacer()
            
            HStack() {
                Text(date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")
                    .lineLimit(1)
                    .font(.system(.subheadline, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 5)
                    .frame(width: 120)
                    .frame(maxWidth: 140)
                    .frame(height: 40)
                    .background(.backgroundColor5)
                    .clipShape(.rect(cornerRadius: 8))
                    .padding(.horizontal, 2)

                Text(amount, format: .localCurrency)
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
        .background(.backgroundColor4)
        .clipShape(.rect(cornerRadius: 8))
        .padding(4)
        .background(.backgroundColor3)
        .clipShape(.rect(cornerRadius: 8))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Transaction \(nameActivity), \(amount), \(date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")")
    }
}

#Preview("Light") {
    PayementActivityCell(icon: "arrowtriangle.up.circle.fill", nameActivity: "MacBook Pro 16 M2 Max", amount: 3700, date: .now, textColor: .complementary)
        .padding(5)
}

#Preview("Dark") {
    PayementActivityCell(icon: "arrowtriangle.up.circle.fill", nameActivity: "MacBook Pro 16 M2 Max", amount: 3700, date: .now, textColor: .complementary)
        .padding(5)
        .preferredColorScheme(.dark)
}
