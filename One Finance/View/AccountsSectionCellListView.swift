//
//  AccountsSectionCellListView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 06/09/2024.
//

import SwiftUI

struct AccountsSectionCellListView: View {
    
    var accounts: [Account]
    
    var body: some View {
        ForEach(accounts) { account in
            ZStack {
                NavigationLink {
                    AccountDetailView(account: account)
                } label: {
                    EmptyView()
                }
                .opacity(0)
                AccountCellListView(account: account)
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.backgroundColor5)
    }
}
