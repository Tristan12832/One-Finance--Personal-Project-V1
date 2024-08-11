//
//  AccountsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftData
import SwiftUI

struct AccountsView: View {
    @AppStorage("showingGrid") private var showingGrid = true
    @Environment(\.modelContext) var modelContext
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Query(animation: .default) var accounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isFavorite == true }, animation: .default) var favoriteAccounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isMarked == true}, animation: .default) var markedAccounts: [Account]
    @State private var showingNewAccount = false
    
    let paddingHorizontalList: CGFloat = -14
    let paddingHorizontal: CGFloat = 20
    
    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    func deleteAccounts(_ indexSet: IndexSet) {
        for index in indexSet {
            let account = accounts[index]
            modelContext.delete(account)
        }
    }
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    ScrollView {
                        LazyVStack(alignment:.leading, spacing: 18){
                            Text("Favorite")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .padding(.horizontal, paddingHorizontal)
                            
                            LazyVGrid(columns: columns, spacing: 18) {
                                ForEach(favoriteAccounts.indices, id: \.self) { account in
                                    NavigationLink {
                                        AccountDetailView(account: favoriteAccounts[account])
                                    } label: {
                                        AccountCellView(account: favoriteAccounts[account])
                                    }
                                }
                            }
                            .padding(.horizontal, paddingHorizontal)
                            
                            Spacer()
                            
                            Text("Marked")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .padding(.horizontal, paddingHorizontal)
                            
                            LazyVGrid(columns: columns, spacing: 18) {
                                ForEach(markedAccounts.indices, id: \.self) { account in
                                    NavigationLink {
                                        AccountDetailView(account: markedAccounts[account])
                                    } label: {
                                        AccountCellView(account: markedAccounts[account])
                                    }
                                }
                            }
                            .padding(.horizontal, paddingHorizontal)
                            
                            Spacer()
                            
                            Text("All Accounts")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .padding(.horizontal, paddingHorizontal)
                            
                            LazyVGrid(columns: columns, spacing: 18) {
                                ForEach(accounts.indices, id: \.self) { account in
                                    NavigationLink {
                                        AccountDetailView(account: accounts[account])
                                    } label: {
                                        AccountCellView(account: accounts[account])
                                    }
                                }
                            }
                            .padding(.horizontal, paddingHorizontal)
                            
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .background(.backgroundColor5)
                    .toolbarBackground(Color.backgroundColor5)
                } else {
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
                            .listRowInsets(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.backgroundColor5)
                            
                        } header: {
                            Text("Favorite")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
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
                            .listRowInsets(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.backgroundColor5)
                            
                        } header: {
                            Text("Marked")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
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
                            .listRowInsets(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.backgroundColor5)
                            
                        } header: {
                            Text("All Account")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                        }
                        .headerProminence(.increased)
                        
                    }
                    .padding(.horizontal, paddingHorizontalList)
                    .scrollContentBackground(.hidden)
                    .background(.backgroundColor5)
                    
                }
            }
            .navigationTitle("Accounts")
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    withAnimation(.default) {
                        showingGrid.toggle()
                    }
                } label: {
                    if showingGrid {
                        Label("Show as grid", systemImage: "menucard")
                            .accessibilityHint("Press to switch to list presentation.")
                    } else {
                        Label("Show as list", systemImage: "list.dash")
                            .accessibilityHint("Press to switch to grid presentation.")
                        
                    }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    self.showingNewAccount = true
                } label: {
                    Label("Add a new account", systemImage: "plus")
                }
                .accessibilityHint("Press Add new account, to add a new account to your list of accounts in the application!")
            }
            
        }
        .sheet(isPresented: $showingNewAccount) {
            withAnimation(.snappy) {
                NewAccountView()
            }
        }
        
    }
}

#Preview("AccountsView") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    return NavigationStack {
        AccountsView()
    }
    .modelContainer(container)
    
}

#Preview("AccountsView + Sidebar", traits: .landscapeLeft) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    return NavigationSplitView {
        SidebarPreview()
    } detail: {
        AccountsView()
    }
    .modelContainer(container)
    
}

#Preview("AccountsView + Sidebar + Dark mode", traits: .landscapeRight) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    let account1 = Account(name: "Compte Test", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account1)
    
    return NavigationSplitView {
        SidebarPreview()
    } detail: {
        AccountsView()
    }
    .modelContainer(container)
    .preferredColorScheme(.dark)
}
