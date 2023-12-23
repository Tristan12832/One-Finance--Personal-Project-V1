//
//  CustomButtonDateStyle.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/11/2023.
//

import SwiftUI

struct CustomButtonDateStyle: ButtonStyle {
    let colorButton: Color
    let colorText: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(3)
            .padding(.horizontal, 10)
            .foregroundStyle(colorText)
            .background(colorButton)
            .font(.system(.headline, design: .rounded))
            .clipShape(.rect(cornerRadius: 8))
    }
}

