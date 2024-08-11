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
    
    private let columns = [
        GridItem(.adaptive(minimum: 200, maximum: .infinity))
    ]
    
    private let paddingHorizontal: CGFloat = 20
    
    @State private var showingNewAccount = false
    

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment:.leading, spacing: 18){
                    Text("Favorite")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, paddingHorizontal)
                        .accessibilityAddTraits(.isHeader)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(favoriteAccounts) { account in
                            NavigationLink {
                                AccountDetailView(account: account)
                            } label: {
                                AccountCellView(account: account)
                            }
                        }
                    }
                    .padding(.horizontal, paddingHorizontal)
                    
                    Spacer()
                    
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, paddingHorizontal)
                        .accessibilityAddTraits(.isHeader)

                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(markedAccounts) { account in
                            NavigationLink {
                                AccountDetailView(account: account)
                            } label: {
                                AccountCellView(account: account)
                            }
                        }
                    }
                    .padding(.horizontal, paddingHorizontal)
                    
                    Spacer()
                    
                    Text("All Accounts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, paddingHorizontal)
                        .accessibilityAddTraits(.isHeader)

                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(accounts) { account in
                            NavigationLink {
                                AccountDetailView(account: account)
                            } label: {
                                AccountCellView(account: account)
                            }
                        }
                    }
                    .padding(.horizontal, paddingHorizontal)
                    
                    Spacer()

                    Text("Some Charts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, paddingHorizontal)
                        .accessibilityAddTraits(.isHeader)

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
