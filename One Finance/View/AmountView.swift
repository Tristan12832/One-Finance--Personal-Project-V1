//
//  AmountView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 12/09/2023.
//

import SwiftUI

//MARK: AmountView component
struct AmountView: View {
    
    var title: String
    var amount: Double
    var backgroundColor: Color
    
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
        .cornerRadius(8)
        
    }
}


struct AmountView_Previews: PreviewProvider {
    static var previews: some View {
        AmountView(title: "Test", amount: 9999, backgroundColor: .myGreen)
            .previewLayout(.sizeThatFits)
    }
}
