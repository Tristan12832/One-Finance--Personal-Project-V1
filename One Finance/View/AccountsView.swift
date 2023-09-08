//
//  AccountsView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftUI

struct AccountsView: View {
    @StateObject var model = ExampleAccounts()
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
                            AccountCellView(name: model.isFavoriteFilter[index].name, icon: model.isFavoriteFilter[index].icon, amount: Double(model.isFavoriteFilter[index].totalBalance), isFavorite: $model.isFavoriteFilter[index].isFavorite, isMarked: $model.isFavoriteFilter[index].isMarked)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("Marked")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(model.isMarkedFilter.indices) { index in
                            AccountCellView(name: model.isMarkedFilter[index].name, icon: model.isMarkedFilter[index].icon, amount: Double(model.isMarkedFilter[index].totalBalance), isFavorite: $model.isMarkedFilter[index].isFavorite, isMarked: $model.isMarkedFilter[index].isMarked)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("All Accounts")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(model.example_Accounts.indices) { index in
                            AccountCellView(name: model.example_Accounts[index].name, icon: model.example_Accounts[index].icon, amount: Double(model.example_Accounts[index].totalBalance), isFavorite: $model.example_Accounts[index].isFavorite, isMarked: $model.example_Accounts[index].isMarked)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .background(.lightBackground5)
            
            .navigationTitle("Accounts")
            .toolbarBackground(Color.lightBackground5)
        }
        
    }
}

struct AccountsView_Previews: PreviewProvider {
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.dashboard
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationSplitView {
            NavigationStack{
                SidebarPreview()
            }
        } detail: {
            AccountsView()
        }
        .tint(.accentColor)
        .previewDevice("Preview Full")
        
        NavigationSplitView {
            SidebarPreview()
        } detail: {
            AccountsView()
        }
        .tint(.accentColor)
        .previewInterfaceOrientation(.landscapeRight)
        .previewDevice("Preview landscapeRight")
        
    }
}
