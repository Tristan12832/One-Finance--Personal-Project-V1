//
//  DashboardView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 31/08/2023.
//

import SwiftData
import SwiftUI

struct DashboardView: View {
    @Environment(\.modelContext) var modelContext
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
        #if DEBUG
            ToolbarItem(placement: .automatic) {
                Button {
                    addSamples()
                } label: {
                    Label("ADD SAMPLES", systemImage: "flame")
                }
                .help("ADD SAMPLES")
            }
        #endif
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
    
#if DEBUG
    private func addSamples() {
        try? modelContext.delete(model: Account.self)
        
        let payments_1 = [
            PaymentActivity(name: "Salaire", amount: 2600.00, date: Date(), type: .income),
            PaymentActivity(name: "Loyer", amount: 850.00, date: Date(), type: .expense),
            PaymentActivity(name: "Courses Supermarché", amount: 150.00, date: Date(), type: .expense),
            PaymentActivity(name: "Électricité", amount: 60.00, date: Date(), type: .expense),
            PaymentActivity(name: "Internet", amount: 40.00, date: Date(), type: .expense),
            PaymentActivity(name: "Abonnement Téléphone", amount: 30.00, date: Date(), type: .expense),
            PaymentActivity(name: "Essence", amount: 50.00, date: Date(), type: .expense),
            PaymentActivity(name: "Remboursement assurance santé", amount: 120.00, date: Date(), type: .income),
            PaymentActivity(name: "Restaurant", amount: 45.00, date: Date(), type: .expense),
            PaymentActivity(name: "Vêtements", amount: 80.00, date: Date(), type: .expense),
            PaymentActivity(name: "Abonnement Netflix", amount: 12.00, date: Date(), type: .expense),
            PaymentActivity(name: "Café et snacks", amount: 25.00, date: Date(), type: .expense),
            PaymentActivity(name: "Dépenses Loisir", amount: 100.00, date: Date(), type: .expense),
            PaymentActivity(name: "Épargne Mensuelle", amount: 200.00, date: Date(), type: .expense),
            PaymentActivity(name: "Prime Salaire", amount: 300.00, date: Date(), type: .income),
            PaymentActivity(name: "Transport en commun", amount: 50.00, date: Date(), type: .expense),
            PaymentActivity(name: "Assurance Voiture", amount: 100.00, date: Date(), type: .expense),
            PaymentActivity(name: "Livres", amount: 30.00, date: Date(), type: .expense),
            PaymentActivity(name: "Remboursement Impôt", amount: 500.00, date: Date(), type: .income),
            PaymentActivity(name: "Dons", amount: 20.00, date: Date(), type: .expense)

        ]
        let account1 = Account(
            name: "Compte à Vue",
            icon: "house.fill",
            payments: [],
            isFavorite: true,
            isMarked: false
        )
        modelContext.insert(account1)
        for payment in payments_1 {
            account1.payments.append(payment)
        }
        
        let payments_2 = [
            PaymentActivity(name: "Épargne Mensuelle", amount: 4000.00, date: .distantPast, type: .income),
            PaymentActivity(name: "Épargne Mensuelle", amount: 500.00, date: Date(), type: .income),
            PaymentActivity(name: "Intérêts Épargne", amount: 15.00, date: Date(), type: .income),
            PaymentActivity(name: "Transfert d'épargne", amount: 200.00, date: Date(), type: .expense),
            PaymentActivity(name: "Remboursement épargne", amount: 100.00, date: Date(), type: .income),
            PaymentActivity(name: "Versement Extra", amount: 300.00, date: Date(), type: .expense)
        ]
        let account2 = Account(
            name: "Compte Épargne",
            icon: "tree.fill",
            payments: [],
            isFavorite: false,
            isMarked: true
        )
        modelContext.insert(account2)
        
        for payment in payments_2 {
            account2.payments.append(payment)
        }
        
        let account3 = Account(
            name: "Compte Commun",
            icon: "creditcard.fill",
            payments: [],
            isFavorite: false,
            isMarked: false
        )
        modelContext.insert(account3)
        
        let payments_3 = [
            PaymentActivity(name: "Paiement Facture Eau", amount: 80.00, date: Date(), type: .expense),
            PaymentActivity(name: "Paiement Facture Gaz", amount: 100.00, date: Date(), type: .expense),
            PaymentActivity(name: "Courses Ménagères", amount: 200.00, date: Date(), type: .expense),
            PaymentActivity(name: "Remboursement Amis", amount: 50.00, date: Date(), type: .income),
            PaymentActivity(name: "Prime Commun", amount: 150.00, date: Date(), type: .income),
            PaymentActivity(name: "Réparations Voiture", amount: 300.00, date: Date(), type: .expense),
            PaymentActivity(name: "Dépense Commune Loisirs", amount: 120.00, date: Date(), type: .expense)

        ]
        for payment in payments_3 {
            account3.payments.append(payment)
        }

    }
#endif
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
