//
//  One_FinanceApp.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftData
import SwiftUI

@main
struct One_FinanceApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Account.self, PaymentActivity.self])
    }
}
