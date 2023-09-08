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
    
    var name: String
    var icon: String
    var amount: Double
    @Binding var isFavorite: Bool
    @Binding var isMarked: Bool
    
    var body: some View {
        HStack {
            IconViewAccountListViewCell(icon: icon)
            
            InfoAccountViewCell(acoounName: name, amount: amount, backgroundColor: .lightBackground5)
            
            Spacer()
            
            //MARK: FAVORI and MARK
            HStack(spacing: 5) {
                if isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(.title2, weight: .semibold))
                }
                
                if isMarked {
                    Image(systemName: "flag.fill")
                        .foregroundColor(.red)
                        .font(.system(.title2, weight: .semibold))
                }
            }
            .padding(.horizontal, 5)
        }
        .padding()
        .background(.lightBackground4)
        .padding(8)
        .background(.myGreenApple_light)
        .cornerRadius(8)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(.lightBackground5, lineWidth: 6)
        }
        .fixedSize(horizontal: false, vertical: true)
        
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
        NavigationStack {
            AccountCellListView(name: "Account Name", icon: "house.fill", amount: 5000, isFavorite: .constant(true), isMarked: .constant(true))
        }
        .previewDisplayName("AccountCellListView")
        
        NavigationStack {
            AccountCellListView(name: "Account Name", icon: "house.fill", amount: 5000, isFavorite: .constant(true), isMarked: .constant(true))
        }
        .previewDisplayName("Preview Without Sidebar")
        .tint(Color.myGreenApple_light)
        .preferredColorScheme(.light)
        
        NavigationSplitView {
            NavigationStack {
                SidebarPreview()
            }
        } detail: {
            List {
                ForEach(0..<10) { _ in
                    AccountCellListView(name: "Account Name", icon: "house.fill", amount: 5000, isFavorite: .constant(true), isMarked: .constant(true))
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        }
        .previewDisplayName("Preview With Sidebar -landscapeLeft")
        .previewInterfaceOrientation(.landscapeRight)
        .tint(Color.myGreenApple_light)
        .preferredColorScheme(.light)
        
        NavigationSplitView {
            SidebarPreview()
        } detail: {
            List {
                ForEach(0..<10) { _ in
                    AccountCellListView(name: "Account Name", icon: "house.fill", amount: 5000, isFavorite: .constant(true), isMarked: .constant(true))                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }
        .previewDisplayName("Preview With Sidebar")
        .previewInterfaceOrientation(.portrait)
        .tint(Color.myGreenApple_light)
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
