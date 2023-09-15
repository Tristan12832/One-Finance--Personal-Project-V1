//
//  DetailColumn.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/09/2023.
//

import SwiftUI

struct DetailColumn: View {
    
    @Binding var selection: Panel?
    @ObservedObject var model: Acounts
    
    var body: some View {
        switch selection ?? .dashboard {
        case .dashboard:
            DashboardView(model: model, navigationSelection: $selection)
        case .accounts:
            AccountsView(model: model)
            //MARK: FUTUR
        case .history:
            HistoryView()
        case .projects:
            ProjectsView()
        }
    }
}

struct DetailColumn_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct Preview: View {
        @State private var selection: Panel? = Panel.dashboard
        @StateObject private var model = Acounts()
        var body: some View {
            DetailColumn(selection: $selection, model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
