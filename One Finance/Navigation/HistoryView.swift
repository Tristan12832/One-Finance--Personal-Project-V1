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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColor5)
    }
}


#Preview {
    HistoryView()
}

#Preview("Preview + Sidebar", traits: .landscapeRight) {
    NavigationSplitView {
        Sidebar(selection: .constant(.dashboard))
    } detail: {
        HistoryView()
    }
   
}

#Preview("Preview + Sidebar", traits: .landscapeRight) {
    NavigationSplitView {
        Sidebar(selection: .constant(.dashboard))
    } detail: {
        HistoryView()
    }
    .preferredColorScheme(.dark)
}
