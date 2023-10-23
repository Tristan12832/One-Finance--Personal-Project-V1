//
//  ContentView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var accounts: Accounts
    
    @State private var selection: Panel? = Panel.dashboard
    @State private var path = NavigationPath()

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selection)
                .toolbarBackground(Color.backgroundColor5)
        } detail: {
            NavigationStack(path: $path) {
                DetailColumn(selection: $selection, accounts: accounts)
            }
            .toolbarBackground(Color.backgroundColor5)
        }
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    ///init the "Preview" to display 
    struct Preview: View {
        @StateObject private var accounts = Accounts()
        var body: some View {
            ContentView(accounts: Accounts())
        }
    }
    
//    ///init the sidebar to display on "Preview"
//    struct SidebarPreview: View {
//        @State private var selection: Panel? = Panel.accounts
//        var body: some View {
//            Sidebar(selection: $selection)
//        }
//    }
    
    static var previews: some View {
        Preview()
            .previewDisplayName("Preview Standard")

        Preview()
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPad Air (5th generation)")
            .previewDisplayName("Preview iPad")

    }
}
