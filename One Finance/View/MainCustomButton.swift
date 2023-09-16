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
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.myGreen)
                    .cornerRadius(.infinity)
        }
    }
}


struct MainCustomButton_Previews: PreviewProvider {
    static var previews: some View {
        MainCustomButton(title: "Title HERE !!!") {
            print("Test button")
        }
    }
}
