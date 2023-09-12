//
//  AccountsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftUI

struct AccountsView: View {
    @ObservedObject var model: ExampleAccounts
    
    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading, spacing: 18){
                    Text("Favorite")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(model.isFavoriteFilter.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(model: model.isFavoriteFilter[index])
                            } label: {
                                AccountCellView(name: model.isFavoriteFilter[index].name, icon: model.isFavoriteFilter[index].icon, amount: Double(model.isFavoriteFilter[index].totalBalance), isFavorite: $model.isFavoriteFilter[index].isFavorite, isMarked: $model.isFavoriteFilter[index].isMarked)
                            }

                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(model.isMarkedFilter.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(model: model.isMarkedFilter[index])
                            } label: {
                                AccountCellView(name: model.isMarkedFilter[index].name, icon: model.isMarkedFilter[index].icon, amount: Double(model.isMarkedFilter[index].totalBalance), isFavorite: $model.isMarkedFilter[index].isFavorite, isMarked: $model.isMarkedFilter[index].isMarked)
                            }

                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("All Accounts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(model.example_Accounts.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(model: model.example_Accounts[index])
                            } label: {
                                AccountCellView(name: model.example_Accounts[index].name, icon: model.example_Accounts[index].icon, amount: Double(model.example_Accounts[index].totalBalance), isFavorite: $model.example_Accounts[index].isFavorite, isMarked: $model.example_Accounts[index].isMarked)
                            }

                        }
                    }
                    .padding(.horizontal, 30)
                    
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .background(.backgroundColor5)
            
            .navigationTitle("Accounts")
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

            }
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                   //more action
                } label: {
                    Image(systemName: "plus")
                        .font(.system(.title2))
                }

            }

        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    ///init the "Preview" to display on 
    struct Preview: View {
        @StateObject private var model = ExampleAccounts()
        var body: some View {
            AccountsView(model: model)
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
