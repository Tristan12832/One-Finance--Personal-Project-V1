//
//  AccountsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftData
import SwiftUI

struct AccountsView: View {
    @Query(animation: .default) var accounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isFavorite == true }, animation: .default) var favoriteAccounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isMarked == true}, animation: .default) var markedAccounts: [Account]
    @State private var showingNewAccount = false

    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(favoriteAccounts.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: favoriteAccounts[index])
                        } label: {
                            AccountCellListView(name: favoriteAccounts[index].name, icon: favoriteAccounts[index].icon, amount: favoriteAccounts[index].totalBalance, isFavorite: favoriteAccounts[index].isFavorite, isMarked: favoriteAccounts[index].isMarked)
                        }
                    }
                    .onDelete(perform: self.accounts.removeAccount)
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
                            AccountCellListView(name: markedAccounts[index].name, icon: markedAccounts[index].icon, amount: Double(markedAccounts[index].totalBalance), isFavorite: markedAccounts[index].isFavorite, isMarked: markedAccounts[index].isMarked)
                        }
                    }
                    .onDelete(perform: self.accounts.removeAccount)
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
                            AccountCellListView(name: accounts[index].name, icon: accounts.accounts[index].icon, amount: Double(accounts[index].totalBalance), isFavorite: accounts[index].isFavorite, isMarked: accounts[index].isMarked)
                        }
                    }
                    .onDelete(perform: self.accounts.removeAccount)
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
            NewAccountView(accounts: accounts)
        }
        
    }
}

struct AccountsView_Previews: PreviewProvider {
    ///init the "Preview" to display on 
    struct Preview: View {
        @State private var account = Accounts(accounts: [])
        var body: some View {
            AccountsView(accounts: account)
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
