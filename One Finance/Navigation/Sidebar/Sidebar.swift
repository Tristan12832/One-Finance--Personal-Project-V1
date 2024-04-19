//
//  SideBar.swift
//  One Finance
//
//  Created by Tristan Stenuit on 28/08/2023.
//

import SwiftUI

enum Panel: Hashable {
    case dashboard
    case accounts
    case history
    case projects
}

struct Sidebar: View {
    
    @Binding var selection: Panel?

    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: Panel.dashboard) {
                Label("Dashboard", systemImage: "list.clipboard")
            }
            .listRowSeparator(.hidden)

            NavigationLink(value: Panel.accounts) {
                Label("Accounts", systemImage: "person.crop.circle")
            }
            .listRowSeparator(.hidden)

            //Futur
            NavigationLink(value: Panel.history) {
                Label("History", systemImage: "clock.fill")
            }
            .listRowSeparator(.hidden)

            Section("Tips") {
                //Futur
            }

            Section("Projects") {
                //Futur
            }

        }
        .listStyle(.sidebar)
        .navigationTitle("Menu")
        .scrollContentBackground(.hidden)
        .background(.backgroundColor5)
        .tint(Color.myGreen)
    }
}

//MARK: Preview
struct Sidebar_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct Preview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationSplitView {
            Preview()
        } detail: {
           Text("Detail!")
        }
        .previewInterfaceOrientation(.portrait)
        .tint(Color.myGreen)

        NavigationSplitView {
            Preview()
        } detail: {
           Text("Detail!")
        }
        .previewInterfaceOrientation(.landscapeRight)
        .tint(Color.myGreen)

    }
}
