//
//  DetailColumn.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/09/2023.
//

import SwiftData
import SwiftUI

struct DetailColumn: View {
    
    @Binding var selection: Panel?

    var body: some View {
        switch selection ?? .dashboard {
        case .dashboard:
            DashboardView(navigationSelection: $selection)
        case .accounts:
            AccountsView()
            //MARK: FUTUR
        case .history:
            HistoryView()
        case .projects:
            ProjectsView()
        }
    }
}

#Preview {
    @State  var selection: Panel? = Panel.dashboard

        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Account.self, configurations: config)
        
        let account = Account(name: "Compte à vue", icon: "house.fill", payments: [PaymentActivity(name: "MBP 15", amount: 5639, date: .now, type: .expense), PaymentActivity(name: "Income", amount: 999, date: .distantPast, type: .income)], isFavorite: false, isMarked: false)
        container.mainContext.insert(account)
        
    return DetailColumn(selection: $selection)
            .modelContainer(container)
}
