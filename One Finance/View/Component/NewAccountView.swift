//
//  NewAccountView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftUI

struct NewAccountView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var accounts: Accounts
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView(accounts: Accounts())
    }
}
