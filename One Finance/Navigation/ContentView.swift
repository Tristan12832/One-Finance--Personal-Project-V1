//
//  ContentView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: ExampleAccounts
    
    @State private var selection: Panel? = Panel.dashboard
    @State private var ppath = NavigationPath()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct Preview: View {
        @StateObject private var model = ExampleAccounts()
        var body: some View {
            ContentView(model: ExampleAccounts())
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
