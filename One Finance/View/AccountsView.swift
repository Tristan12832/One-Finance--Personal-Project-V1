//
//  AccountsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftUI

struct AccountsView: View {
    @ObservedObject var accounts: Accounts
    
    @State private var showingNewAccount = false

    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(accounts.isFavoriteFilter.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: accounts.isFavoriteFilter[index])
                        } label: {
                            AccountCellListView(name: accounts.isFavoriteFilter[index].name, icon: accounts.isFavoriteFilter[index].icon, amount: accounts.isFavoriteFilter[index].totalBalance, isFavorite: $accounts.isFavoriteFilter[index].isFavorite, isMarked: $accounts.isFavoriteFilter[index].isMarked)
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
                    ForEach(accounts.isMarkedFilter.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: accounts.isMarkedFilter[index])
                        } label: {
                            AccountCellListView(name: accounts.isMarkedFilter[index].name, icon: accounts.isMarkedFilter[index].icon, amount: Double(accounts.isMarkedFilter[index].totalBalance), isFavorite: $accounts.isMarkedFilter[index].isFavorite, isMarked: $accounts.isMarkedFilter[index].isMarked)
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
                    ForEach(accounts.accounts.indices, id: \.self) { index in
                        NavigationLink {
                            AccountDetailView(account: accounts.accounts[index])
                        } label: {
                            AccountCellListView(name: accounts.accounts[index].name, icon: accounts.accounts[index].icon, amount: Double(accounts.accounts[index].totalBalance), isFavorite: $accounts.accounts[index].isFavorite, isMarked: $accounts.accounts[index].isMarked)
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
        @StateObject private var account = Accounts()
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
