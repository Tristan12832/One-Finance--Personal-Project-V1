//
//  DetailColumn.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/09/2023.
//

import SwiftUI

struct DetailColumn: View {
    
    @Binding var selection: Panel?
    @ObservedObject var accounts: Accounts
    
    var body: some View {
        switch selection ?? .dashboard {
        case .dashboard:
            DashboardView(accounts: accounts, navigationSelection: $selection)
        case .accounts:
            AccountsView(accounts: accounts)
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
        @StateObject private var model = Accounts()
        var body: some View {
            DetailColumn(selection: $selection, accounts: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
