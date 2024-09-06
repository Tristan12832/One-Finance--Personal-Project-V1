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
    
    @State private var showingNewAccount = false

    @Query(animation: .default) var accounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isFavorite == true }, animation: .default) var favoriteAccounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isMarked == true}, animation: .default) var markedAccounts: [Account]
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    ScrollView {
                        LazyVStack(alignment:.leading, spacing: 18){
                            Text("Favorite")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .paddingHorizontal()
                            AccountsSectionListView(accounts: favoriteAccounts)
                            
                            Spacer()
                            
                            Text("Marked")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .paddingHorizontal()
                            AccountsSectionListView(accounts: markedAccounts)
                            
                            
                            Spacer()
                            
                            Text("All Accounts")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                                .paddingHorizontal()
                            AccountsSectionListView(accounts: accounts)
                            
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .background(.backgroundColor5)
                    .toolbarBackground(Color.backgroundColor5)
                } else {
                    List {
                        Section {
                            AccountsSectionCellListView(accounts: favoriteAccounts)
                        } header: {
                            Text("Favorite")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                        }
                        .headerProminence(.increased)
                        
                        Section {
                            AccountsSectionCellListView(accounts: markedAccounts)
                        } header: {
                            Text("Marked")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                        }
                        .headerProminence(.increased)
                        
                        Section {
                            AccountsSectionCellListView(accounts: accounts)
                        } header: {
                            Text("All Account")
                                .font(.system(.title, design: .rounded, weight: .bold))
                                .accessibilityAddTraits(.isHeader)
                        }
                        .headerProminence(.increased)
                        
                    }
                    .paddingHorizontalList()
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
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
                    withAnimation(.bouncy) {
                        self.showingNewAccount = true
                    }
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
