//
//  DashboardView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 31/08/2023.
//

import SwiftData
import SwiftUI

struct DashboardView: View {
    @Environment(\.modelContext) var context
    
    @Query(animation: .default) var accounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isFavorite == true }, animation: .default) var favoriteAccounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isMarked == true}, animation: .default) var markedAccounts: [Account]
    @Binding var navigationSelection: Panel?
    
    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    @State private var showingNewAccount = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading, spacing: 18){
                    Text("Favorite")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(favoriteAccounts.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(account: favoriteAccounts[index])
                            } label: {
                                AccountCellView(account: favoriteAccounts[index])
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(markedAccounts.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(account: markedAccounts[index])
                            } label: {
                                AccountCellView(account: markedAccounts[index])
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("All Accounts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(accounts.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(account: accounts[index])
                            } label: {
                                AccountCellView(account: accounts[index])
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .background(.backgroundColor5)
            
            .navigationTitle("Dashboar")
            .toolbarBackground(Color.backgroundColor5)
            
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    //more action
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(.title2))
                }
                .accessibilityLabel("Help")
                .accessibilityHint("Need help? it's here")
            }
        }
        .sheet(isPresented: $showingNewAccount) {
            NewAccountView()
        }
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    ///init the "Preview" to display on
    struct Preview: View {
        @State private var accounts = Accounts(accounts: [])
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(navigationSelection: $navigationSelection)
        }
    }
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.dashboard
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationStack{
            Preview()
        }
        .previewDisplayName("Preview standard")
        
        NavigationSplitView {
            SidebarPreview()
        } detail: {
            Preview()
                .background(.backgroundColor5)
        }
        .previewInterfaceOrientation(.landscapeRight)
        .previewDevice("iPad Air (5th generation)")
        .previewDisplayName("Preview for iPad")
    }
}
