//
//  AccountsSectionListView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 06/09/2024.
//

import SwiftUI

struct AccountsSectionListView: View {
    
    var accounts: [Account]
    
    private let columns = [
        GridItem(.adaptive(minimum: 200, maximum: .infinity))
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 18) {
            ForEach(accounts) { account in
                NavigationLink {
                    AccountDetailView(account: account)
                } label: {
                    AccountCellView(account: account)
                }
            }
        }
        .paddingHorizontal()
    }
}
