//
//  ContentView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 25/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: ExampleAccounts
    
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
    static var previews: some View {
        ContentView(model: ExampleAccounts())
    }
}
