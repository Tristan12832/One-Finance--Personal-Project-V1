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

struct DetailColumn_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct Preview: View {
        @State private var selection: Panel? = Panel.dashboard
        @State private var accounts = Accounts(accounts: [])
        var body: some View {
            DetailColumn(selection: $selection)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
