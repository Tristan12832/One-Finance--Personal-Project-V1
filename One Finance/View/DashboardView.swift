//
//  DashboardView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 31/08/2023.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var accounts: Accounts
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
                        ForEach(accounts.isFavoriteFilter.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(account: accounts.isFavoriteFilter[index])
                            } label: {
                                AccountCellView(name: accounts.isFavoriteFilter[index].name, icon: accounts.isFavoriteFilter[index].icon, amount: accounts.isFavoriteFilter[index].totalBalance, isFavorite: $accounts.isFavoriteFilter[index].isFavorite, isMarked: $accounts.isFavoriteFilter[index].isMarked)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(accounts.isMarkedFilter.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(account: accounts.isMarkedFilter[index])
                            } label: {
                                AccountCellView(name: accounts.isMarkedFilter[index].name, icon: accounts.isMarkedFilter[index].icon, amount: Double(accounts.isMarkedFilter[index].totalBalance), isFavorite: $accounts.isMarkedFilter[index].isFavorite, isMarked: $accounts.isMarkedFilter[index].isMarked)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("All Accounts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(accounts.accounts.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(account: accounts.accounts[index])
                            } label: {
                                AccountCellView(name: accounts.accounts[index].name, icon: accounts.accounts[index].icon, amount: Double(accounts.accounts[index].totalBalance), isFavorite: $accounts.accounts[index].isFavorite, isMarked: $accounts.accounts[index].isMarked)
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
            NewAccountView(accounts: accounts)
        }
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    ///init the "Preview" to display on
    struct Preview: View {
        @StateObject private var accounts = Accounts()
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(accounts: accounts, navigationSelection: $navigationSelection)
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
