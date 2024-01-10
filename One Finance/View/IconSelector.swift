//
//  IconSelector.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftUI

struct IconSelector: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedIcon: String
    
    private let icons = [
        "house.fill",
        "tree.fill",
        "creditcard.fill",
        "graduationcap.fill",
        "gamecontroller.fill",
        "car.rear.fill",
        "tv.inset.filled",
        "airplane",
        "bicycle"
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(icons, id: \.self) { index in
                    Button {
                        selectedIcon = index
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                        .frame(width: 64, height: 64)
                        .foregroundColor(index == selectedIcon ? .backgroundColor4 : .backgroundColor5)
                        .overlay(
                            Image(systemName: index)
                                .foregroundColor(index == selectedIcon ? .myGreen : .primary)
                                .font(.system(size: 32))
                                .fixedSize()
                        )

                    }
                }
            }
            .padding(4)
            .background(colorScheme == .light ? .white : .black)
            .clipShape(.rect(cornerRadius: 8))
            .padding(4)
            .background(Color.backgroundColor4)
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}


#Preview("Preveiw", traits: .sizeThatFitsLayout) {
    @State var previewSelectedIcon = "house.fill"
    return IconSelector(selectedIcon: $previewSelectedIcon)
        .padding(.vertical)
}
