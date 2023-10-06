//
//  AccountCellView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 26/08/2023.
//

import SwiftUI

//MARK: AccountCellView
///Below are the components:
/// - HeaderviewCell component
/// - AmountViewCell component
/// - IconAccountCell component

struct AccountCellView: View {
    var name: String
    var icon: String
    var amount: Double
    @Binding var isFavorite: Bool
    @Binding var isMarked: Bool
    
    var body: some View {
            ZStack {
                VStack(alignment:.center) {
                    HeaderviewCell(acoounName: name, backgroundColor: .myGreen, isFavorite: $isFavorite, isMarked: $isMarked)
                    Spacer()
                    
                    IconAccountCell(icon: icon, iconeColor: .primary)
                    
                    Spacer()
                    
                    AmountViewCell(amount: amount, backgroundColor: .myGreen)
                }
                .fixedSize(horizontal: false, vertical: false)
                
            }
            .background(.backgroundColor4)
            .frame(maxWidth: 270, idealHeight: 420)
            .cornerRadius(8)
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.backgroundColor5, lineWidth: 2)
        }
            .fixedSize(horizontal: false, vertical: true)
            .contextMenu{
                Button {
                    self.isFavorite.toggle()
                } label: {
                    HStack {
                        Text(isFavorite ? "Remove from favorites" : "Mark as favorite")
                        Image(systemName: "star")
                    }
                }
                
                Button {
                    self.isMarked.toggle()
                } label: {
                    HStack {
                        Text(isMarked ? "Remove from marked" : "Mark as marked")
                        Image(systemName: "flag")
                    }
                }
                
                Button(role: .destructive) {
                    
                } label: {
                    HStack {
                        Text("Remove Account")
                        Image(systemName: "trash")
                    }
                }
            }
    }
}

//MARK: Preview
struct AccountCellView_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationSplitView(sidebar: {
            SidebarPreview()
        }, detail: {
            AccountCellView(name: "Account", icon: "house.fill", amount: 5000, isFavorite: .constant(false), isMarked: .constant(false))
        })
            .previewDisplayName("Preview")
            .previewInterfaceOrientation(.portrait)
            .tint(Color.myGreen)
            .previewLayout(.sizeThatFits)
       
    }
}

//MARK: HeaderviewCell component
struct HeaderviewCell: View {

    var acoounName: String
    var backgroundColor: Color
    @Binding var isFavorite: Bool
    @Binding var isMarked: Bool
    
    var body: some View {
        HStack(alignment: .top) {
                Text(acoounName)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
            
            Spacer()
            
            if isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            if isMarked {
                Image(systemName: "flag.fill")
                    .foregroundColor(.red)
            }
        }
        .font(.system(.title2, weight: .semibold))
        .padding(.horizontal, 12)
        .padding(.top, 5)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 60)
        .background(backgroundColor)
    }
}

//MARK: AmountViewCell component
struct AmountViewCell: View {
    
    var amount: Double
    var backgroundColor: Color

    var body: some View {
        Text(amount, format: .localCurrency)
            .foregroundColor(.white)
            .font(.system(.largeTitle, design: .rounded, weight: .heavy))
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 80)
            .background(backgroundColor)
    }
}

//MARK: IconAccountCell component
struct IconAccountCell: View {

    var icon: String
    var iconeColor: Color

    var body: some View {
        Image(systemName: icon)
            .foregroundColor(iconeColor)
            .font(.system(size: 100))
            .fixedSize()
    }
}
