//
//  AccountCellListView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 29/08/2023.
//

import SwiftUI

//MARK: AccountCellListView
///Below are the components:
/// - IconViewAccountListViewCell component
/// - InfoAccountViewCell component


struct AccountCellListView: View {
    @Binding var account: Account
//    var name: String
//    var icon: String
//    var amount: Double
//    @Binding var isFavorite: Bool
//    @Binding var isMarked: Bool
    
    var body: some View {
        HStack {
            IconViewAccountListViewCell(icon: account.icon)
            
            InfoAccountViewCell(acoounName: account.name, amount: account.totalBalance, backgroundColor: .backgroundColor5)
            
            Spacer()
            
            //MARK: FAVORI and MARK
            HStack(spacing: 5) {
                if account.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(.title2, weight: .semibold))
                }
                
                if account.isMarked {
                    Image(systemName: "flag.fill")
                        .foregroundColor(.red)
                        .font(.system(.title2, weight: .semibold))
                }
            }
            .padding(.horizontal, 5)
        }
        .padding()
        .background(.backgroundColor4)
        .padding(8)
        .background(.myGreen)
        .cornerRadius(8)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(.backgroundColor5, lineWidth: 6)
        }
        .fixedSize(horizontal: false, vertical: true)
        .swipeActions(edge: .leading, allowsFullSwipe: false){
            
            Button {
                self.account.isMarked.toggle()
            } label: {
                HStack {
                    Text(account.isMarked ? "Remove from marked" : "Mark as marked")
                    Image(systemName: "flag")
                }
            }
            .tint(.orange)
            Button {
                self.account.isFavorite.toggle()
            } label: {
                HStack {
                    Text(account.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "star")
                }
            }
            .tint(.yellow)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Account \(account.name) with icon of \(account.icon), and you have \(account.totalBalance, format: .localCurrency).")

    }
}

//MARK: Preview
struct AccountCellListView_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        @State var account = Account(name: "Account", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
        
        NavigationStack {
            AccountCellListView(account: $account)
        }
        .previewDisplayName("AccountCellListView")
        
        NavigationStack {
            AccountCellListView(account: $account)
        }
        .previewDisplayName("Preview Without Sidebar")
        .tint(Color.myGreen)
        .preferredColorScheme(.light)
        
        NavigationSplitView {
            NavigationStack {
                SidebarPreview()
            }
        } detail: {
            List {
                ForEach(0..<10) { _ in
                    AccountCellListView(account: $account)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        }
        .previewDisplayName("Preview With Sidebar -landscapeLeft")
        .previewInterfaceOrientation(.landscapeRight)
        .tint(Color.myGreen)
        .preferredColorScheme(.light)
        
        NavigationSplitView {
            SidebarPreview()
        } detail: {
            List {
                ForEach(0..<10) { _ in
                    AccountCellListView(account: $account)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }
        .previewDisplayName("Preview With Sidebar")
        .previewInterfaceOrientation(.portrait)
        .tint(Color.myGreen)
        .preferredColorScheme(.light)
        
    }
}

//MARK: IconViewAccountListViewCell component
struct IconViewAccountListViewCell: View {
    
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(.primary)
            .font(.system(size: 48))
            .fixedSize()
    }
}

//MARK: InfoAccountViewCell component
struct InfoAccountViewCell: View {
    
    var acoounName: String
    var amount: Double
    var backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(acoounName)
                .font(.system(.headline, weight: .semibold))
                .foregroundColor(.primary)
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
            
            Text(amount, format: .localCurrency)
                .lineLimit(1)
                .font(.system(.subheadline, weight: .semibold))
                .foregroundColor(.primary)
                .padding(.horizontal, 5)
                .frame(maxWidth: 140)
                .frame(height: 40)
                .background(backgroundColor)
                .cornerRadius(8)
                .padding(.horizontal, 4)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
