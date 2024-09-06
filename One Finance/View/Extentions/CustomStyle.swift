//
//  CustomStyle.swift
//  One Finance
//
//  Created by Tristan Stenuit on 06/09/2024.
//

import SwiftUI

struct HeaderStyleClassical: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .rounded, weight: .bold))
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(.h1)
    }
}

extension View {
    func headerStyle() -> some View {
        modifier(HeaderStyleClassical())
    }
}

struct HeaderSecondaryStyleClassical: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title2, design: .rounded, weight: .bold))
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(.h2)
    }
}

extension View {
    func headerSecondaryStyle() -> some View {
        modifier(HeaderSecondaryStyleClassical())
    }
}
