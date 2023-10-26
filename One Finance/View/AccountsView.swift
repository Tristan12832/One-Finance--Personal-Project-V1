//
//  AccountsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftData
import SwiftUI

struct AccountsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(animation: .default) var accounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isFavorite == true }, animation: .default) var favoriteAccounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isMarked == true}, animation: .default) var markedAccounts: [Account]
    @State private var showingNewAccount = false

    func deleteAccounts(_ indexSet: IndexSet) {
        for index in indexSet {
            let account = accounts[index]
            modelContext.delete(account)
        }
    }
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(favoriteAccounts.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: favoriteAccounts[index])
                        } label: {
                            AccountCellListView(account: favoriteAccounts[index])
                        }
                    }
                    .onDelete(perform: self.deleteAccounts)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.backgroundColor5)
                    
                } header: {
                    Text("Favorite")
                        .font(.system(.title, design: .rounded, weight: .bold))
                }
                .headerProminence(.increased)
                
                Section {
                    ForEach(markedAccounts.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: markedAccounts[index])
                        } label: {
                            AccountCellListView(account: markedAccounts[index])
                        }
                    }
                    .onDelete(perform: self.deleteAccounts)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.backgroundColor5)
                    
                } header: {
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                }
                .headerProminence(.increased)
                
                Section {
                    ForEach(accounts.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: accounts[index])
                        } label: {
                            AccountCellListView(account: accounts[index])
                        }
                    }
                    .onDelete(perform: self.deleteAccounts)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.backgroundColor5)
                    
                } header: {
                    Text("All Account")
                        .font(.system(.title, design: .rounded, weight: .bold))
                }
                .headerProminence(.increased)
                
            }
            .padding(.horizontal, -18)
            .scrollContentBackground(.hidden)
            .background(.backgroundColor5)
            .navigationTitle("Accounts")
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
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                    self.showingNewAccount = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(.title2))
                }
                .accessibilityLabel("Add")
                .accessibilityHint("Add a new account")


            }

        }
        .sheet(isPresented: $showingNewAccount) {
            NewAccountView()
        }
        
    }
}

struct AccountsView_Previews: PreviewProvider {
    ///init the "Preview" to display on 
    struct Preview: View {
        var body: some View {
            AccountsView()
        }
    }
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationStack {
            Preview()
        }
        .previewDisplayName("Preview Standard")

        NavigationSplitView {
            SidebarPreview()
        } detail: {
            Preview()
        }
        .previewDevice("iPad Air (5th generation)")
        .previewInterfaceOrientation(.landscapeRight)
        .previewDisplayName("Preview iPad")

    }
}
