//
//  CustomSelectionButton.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/10/2023.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    let colorButton: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(3)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .background(colorButton)
            .font(.system(.headline, design: .rounded))
            .cornerRadius(8)
    }
}
