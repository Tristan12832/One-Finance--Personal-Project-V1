//
//  DetailColumn.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/09/2023.
//

import SwiftUI

struct DetailColumn: View {
    
    @Binding var selection: Panel?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailColumn_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct Preview: View {
        @State private var selection: Panel? = Panel.dashboard
        @StateObject private var model = ExampleAccounts()
        var body: some View {
            DetailColumn(selection: $selection)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
