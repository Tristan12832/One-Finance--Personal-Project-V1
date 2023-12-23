//
//  ContentView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @State private var selection: Panel? = Panel.dashboard
    @State private var path = NavigationPath()

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selection)
                .toolbarBackground(Color.backgroundColor5)
        } detail: {
            NavigationStack(path: $path) {
                DetailColumn(selection: $selection)
            }
            .toolbarBackground(Color.backgroundColor5)
        }
       
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [PaymentActivity(name: "MBP 15", amount: 5639, date: .now, type: .expense), PaymentActivity(name: "Income", amount: 999, date: .distantPast, type: .income)], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    return ContentView()
        .modelContainer(container)
}
