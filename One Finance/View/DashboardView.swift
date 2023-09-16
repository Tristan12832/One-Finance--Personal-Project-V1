//
//  DashboardView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 31/08/2023.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var model: Accounts
    @Binding var navigationSelection: Panel?

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
                        ForEach(model.accounts.indices, id: \.self) { index in
                            NavigationLink {
                                AccountDetailView(model: model.accounts[index])
                            } label: {
                                AccountCellView(name: model.accounts[index].name, icon: model.accounts[index].icon, amount: Double(model.accounts[index].totalBalance), isFavorite: $model.accounts[index].isFavorite, isMarked: $model.accounts[index].isMarked)
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

struct DashboardView_Previews: PreviewProvider {
    ///init the "Preview" to display on
    struct Preview: View {
        @StateObject private var model = Accounts()
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(model: model, navigationSelection: $navigationSelection)
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
