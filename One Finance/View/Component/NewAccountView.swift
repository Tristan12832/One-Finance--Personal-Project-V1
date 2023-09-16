//
//  NewAccountView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftUI

struct NewAccountView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var accounts: Accounts
    
    @State private var nameAccount = ""
    @State private var iconeAccount = "house.fill"
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text(nameAccount == "" ? "New account" : nameAccount)
                        TextField("write name account", text: $nameAccount)
                            .padding(8)
                            .background(colorScheme == .light ? .white : .black)
                            .cornerRadius(8)
                    }
                    .font(.system(.title3, weight: .semibold))

                                        
                    VStack(alignment: .leading) {
                        Text("Icone")
                            .font(.title3)
                            .bold()
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.backgroundColor4)
                            IconSelector(selectedIcon: $iconeAccount)
                        }
                    }
                    //BUTTON HERE
                    Spacer()
                    MainCustomButton(title: "Creat !") {
                        print("Creat !")
                    }
                }
                .padding(.horizontal, 10)
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(Color.backgroundColor5)
            .background(.backgroundColor5)
            .navigationTitle("Creat account")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                            .padding()

                    }

                }
            }
        }
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView(accounts: Accounts())
    }
}

