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
    
    @Query(animation: .default) var accounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isFavorite == true }, animation: .default) var favoriteAccounts: [Account]
    @Query(filter: #Predicate<Account> { account in account.isMarked == true}, animation: .default) var markedAccounts: [Account]
    @Binding var navigationSelection: Panel?
    
    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    let paddingHorizontal: CGFloat = 20
    
    @State private var showingNewAccount = false
    

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading, spacing: 18){
                    Text("Favorite")
                        .font(.system(.title, design: .rounded, weight: .bold))
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
                    
                    Spacer()

                    Text("Some Charts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, paddingHorizontal)
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
                    .padding(.horizontal, paddingHorizontal)

                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .background(.backgroundColor5)
            .toolbarBackground(Color.backgroundColor5)
            .navigationTitle("Dashboar")

        }
        .toolbar {
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
            withAnimation(.snappy) {                
                NewAccountView()
            }
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
