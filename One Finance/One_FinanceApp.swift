//
//  One_FinanceApp.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftUI

@main
struct One_FinanceApp: App {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            AccountDetailView()
                .preferredColorScheme(.light)
        }
    }
}
