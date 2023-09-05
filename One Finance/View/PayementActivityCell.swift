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
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(nameActivity)
            
            Spacer()
            
            Text(amount, format: .localCurrency)
            
        }
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
        PayementActivityCell(icon: "arrowtriangle.up.circle.fill", nameActivity: "Expense Name", amount: 200)
    }
}
