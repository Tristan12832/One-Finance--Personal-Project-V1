//
//  MainCustomButton.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftUI

struct MainCustomButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(.title3, design: .rounded,weight: .bold))
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.myGreen, in: .rect(cornerRadius: 32.0))
        }
    }
}



#Preview("Preview", traits: .sizeThatFitsLayout) {
    MainCustomButton(title: "Title HERE !!!") {
        print("Test button")
    }
}

#Preview("Preview - landscapeRight", traits: .landscapeRight, .sizeThatFitsLayout) {
    MainCustomButton(title: "Title HERE !!!") {
        print("Test button")
    }
}
