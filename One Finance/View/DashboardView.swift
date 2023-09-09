//
//  DashboardView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 31/08/2023.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var model: ExampleAccounts
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
                        ForEach(model.isFavoriteFilter.indices) { index in
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
                        ForEach(model.isMarkedFilter.indices) { index in
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
                        ForEach(model.example_Accounts.indices) { index in
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
            .background(.lightBackground5)
            
            .navigationTitle("Dashboar")
            .toolbarBackground(Color.lightBackground5)

        }

        
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    ///init the "Preview" to display on
    struct Preview: View {
        @StateObject private var model = ExampleAccounts()
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
                .background(.lightBackground5)
        }
        .previewInterfaceOrientation(.landscapeRight)
        .previewDevice("iPad Air (5th generation)")
        .previewDisplayName("Preview for iPad")
    }
}
