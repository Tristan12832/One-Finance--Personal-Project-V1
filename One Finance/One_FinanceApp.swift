//
//  One_FinanceApp.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftUI

@main
struct One_FinanceApp: App {
    @StateObject private var model = Accounts()

    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
