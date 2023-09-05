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

            NavigationLink(value: Panel.accounts) {
                Label("Accounts", systemImage: "person.crop.circle")
            }

            NavigationLink(value: Panel.history) {
                Label("History", systemImage: "clock.fill")
            }

            Section("Tips") {
                //Futur
            }

            Section("Projects") {
                //Futur
            }

        }
        .navigationTitle("Menu")
        .scrollContentBackground(.hidden)
        .background(.lightBackground5)
        .tint(Color.myGreenApple_light)

    }
}

//MARK: Preview
struct Sidebar_Previews: PreviewProvider {
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
        .previewInterfaceOrientation(.landscapeLeft)
        .tint(Color.myGreenApple_light)

        Preview()
    }
}
