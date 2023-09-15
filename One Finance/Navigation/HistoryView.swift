//
//  HistoryView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/09/2023.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        Text("Working Progress !!!")
            .font(.system(size: 48, weight: .bold, design: .rounded))
    }
}

struct HistoryView_Previews: PreviewProvider {
    
    ///init the "Preview" to display on
    struct Preview: View {
        @StateObject private var model = Acounts()
        @State private var navigationSelection: Panel? = Panel.dashboard
        var body: some View {
            DashboardView(model: model, navigationSelection: $navigationSelection)
        }
    }
    
    static var previews: some View {
        HistoryView()
            .previewDisplayName("Preview Standard")
        NavigationSplitView {
            Sidebar(selection: .constant(.dashboard))
        } detail: {
            Preview()
                .background(.backgroundColor5)
        }
        .previewInterfaceOrientation(.landscapeRight)
        .previewDevice("iPad Air (5th generation)")
    }
}
