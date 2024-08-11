//
//  AmountView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 12/09/2023.
//

import SwiftUI

//MARK: AmountView component
struct AmountView: View {
    
    let title: String
    var amount: Double
    let backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
            Text(amount, format: .localCurrency)
        }
        .padding(.horizontal, 5)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 100)
        .font(.system(.largeTitle, design: .rounded, weight: .bold))
        .foregroundColor(.white)
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 8))
        .accessibilityElement()
        .accessibilityLabel("\(title), \(amount, format: .localCurrency)")
        .accessibilityAddTraits(.isButton)
        .accessibilityHint("press on the cell to access to \(title)")
        
    }
}


#Preview("Preview -Light", traits: .sizeThatFitsLayout){
    AmountView(title: "Test", amount: 9999, backgroundColor: .myGreen)
        .preferredColorScheme(.light)
}

#Preview("Preview -Dark", traits: .sizeThatFitsLayout){
    AmountView(title: "Test", amount: 9999, backgroundColor: .myGreen)
        .preferredColorScheme(.dark)
}
