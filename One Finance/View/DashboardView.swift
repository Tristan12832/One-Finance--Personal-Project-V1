//
//  DashboardView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 31/08/2023.
//

import SwiftData
import SwiftUI

struct DashboardView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
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
                        ForEach(favoriteAccounts.indices, id: \.self) { account in
                            NavigationLink {
                                AccountDetailView(account: favoriteAccounts[account])
                            } label: {
                                AccountCellView(account: favoriteAccounts[account])
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(markedAccounts.indices, id: \.self) { account in
                            NavigationLink {
                                AccountDetailView(account: markedAccounts[account])
                            } label: {
                                AccountCellView(account: markedAccounts[account])
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("All Accounts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(accounts.indices, id: \.self) { account in
                            NavigationLink {
                                AccountDetailView(account: accounts[account])
                            } label: {
                                AccountCellView(account: accounts[account])
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()

                    Text("Some Charts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    Group {
                        if sizeClass == .compact {
                            VStack {
                                ChartsView()
                                DonutChartView()
                            }
                        } else {
                            HStack(alignment: .top) {
                                ChartsView()
                                DonutChartView()
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

#Preview("Preview") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    ///init the "Preview" to display on
    struct Preview: View {
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(navigationSelection: $navigationSelection)
        }
    }
    
    return NavigationStack{
        Preview()
    }
    .modelContainer(container)
    
}

#Preview("Preview + Sidebar") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.dashboard
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    ///init the "Preview" to display on
    struct Preview: View {
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(navigationSelection: $navigationSelection)
        }
    }
    
    return NavigationSplitView {
        SidebarPreview()
    } detail: {
        Preview()
            .background(.backgroundColor5)
    }
    .modelContainer(container)
    
}

#Preview("Preview + Sidebar + Dark mode") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.dashboard
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    ///init the "Preview" to display on
    struct Preview: View {
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(navigationSelection: $navigationSelection)
        }
    }
    
    return NavigationSplitView {
        SidebarPreview()
    } detail: {
        Preview()
            .background(.backgroundColor5)
    }
    .modelContainer(container)
    .preferredColorScheme(.dark)
}

#Preview("Preview - landscapeLeft+ Sidebar + Dark mode", traits: .landscapeRight) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.dashboard
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    ///init the "Preview" to display on
    struct Preview: View {
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(navigationSelection: $navigationSelection)
        }
    }
    
    let account = Account(name: "Compte à vue", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    container.mainContext.insert(account)
    
    return  NavigationSplitView {
        SidebarPreview()
    } detail: {
        Preview()
            .modelContainer(container)
    }
    
    .preferredColorScheme(.dark)
}
