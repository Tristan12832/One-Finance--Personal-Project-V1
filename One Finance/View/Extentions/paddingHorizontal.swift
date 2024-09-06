//
//  paddingHorizontal.swift
//  One Finance
//
//  Created by Tristan Stenuit on 06/09/2024.
//

import SwiftUI

extension View {
    func paddingHorizontal(horizontalPadding: CGFloat = 20) -> some View {
        self.padding(.horizontal, horizontalPadding)
    }
}
