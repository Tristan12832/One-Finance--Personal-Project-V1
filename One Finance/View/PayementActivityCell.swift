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
    
    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                Text(nameActivity)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: 250, alignment: .leading)
            
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
                    .background(Color.lightBackground5)
                    .cornerRadius(8)
                    .padding(.horizontal, 2)

                Text(amount, format: .localCurrency)
                    .frame(width: 90)
                    .frame(maxWidth: 90, alignment: .trailing)
                    .padding(.horizontal, 2)

            }
            .frame(width: 200, alignment: .trailing)
            .fixedSize(horizontal: true, vertical: false)

        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .padding(2)
        .padding(.vertical, 4)
        .background(.lightBackground4)
        .cornerRadius(8)
        .padding(4)
        .background(.lightBackground3)
        .cornerRadius(8)
    }
}


struct PayementActivityCell_Previews: PreviewProvider {
    static var previews: some View {
        PayementActivityCell(icon: "arrowtriangle.up.circle.fill", nameActivity: "MacBook Pro 16 M2 Max", amount: 2000, date: .now)
            .padding(5)
            
    }
}
