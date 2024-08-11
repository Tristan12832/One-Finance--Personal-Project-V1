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
    
    let paddingHorizontal: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Name of new account")
                        TextField("Write... Ex: Curently Account", text: $nameAccount)
                            .padding(8)
                            .background(colorScheme == .light ? .white : .black)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    .font(.system(.title3, weight: .semibold))

                                        
                    VStack(alignment: .leading) {
                        Text("Icone")
                            .font(.title3)
                            .bold()
              
                            IconSelector(selectedIcon: $iconeAccount)
                    }
                    
                    Spacer(minLength: 25)
                    
                    MainCustomButton(title: "Creat !") {
                        withAnimation(.default) {
                            let newAccount = Account(name: nameAccount, icon: iconeAccount, payments: [], isFavorite: false, isMarked: false)
                            accounts.insert(newAccount)
                            dismiss()
                        }
                    }
                }
                .padding(.horizontal, paddingHorizontal)
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

