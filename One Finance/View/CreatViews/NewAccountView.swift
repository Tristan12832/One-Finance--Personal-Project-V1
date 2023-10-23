//
//  NewAccountView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 16/09/2023.
//

import SwiftData
import SwiftUI

struct NewAccountView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @Environment(\.modelContext) var accounts
    
    @State private var nameAccount = ""
    @State private var iconeAccount = "house.fill"
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text(nameAccount == "" ? "New account" : nameAccount)
                        TextField("Write... Ex: Curently Account", text: $nameAccount)
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
                    Spacer(minLength: 25)
                    MainCustomButton(title: "Creat !") {
                        let newAccount = Account(name: nameAccount, icon: iconeAccount, isFavorite: false, isMarked: false)
                        accounts.insert(newAccount)
                        dismiss()
                    }
                }
                .padding(.horizontal, 10)
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(Color.backgroundColor5)
            .background(.backgroundColor5)
            .navigationTitle("Creat account")
            .navigationBarTitleDisplayMode(.large)
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
        NewAccountView()
    }
}

