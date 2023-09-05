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
    var body: some View {
            ZStack {
                VStack(alignment:.center) {
                    HeaderviewCell(acoounName: "Account Name", backgroundColor: .myGreenApple_light)
                    
                    Spacer()
                    
                    IconAccountCell(icon: "house.fill", iconeColor: .primary)
                    
                    Spacer()
                    
                    AmountViewCell(amount: 100_000, backgroundColor: .myGreenApple_light)
                }
                .fixedSize(horizontal: false, vertical: false)
                
            }
            .background(.lightBackground4)
            .frame(maxWidth: 250, idealHeight: 400)
            .cornerRadius(6)
            .overlay{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.lightBackground5, lineWidth: 2)
        }
            .fixedSize(horizontal: false, vertical: true)
        
    }
}

//MARK: Preview
struct AccountCell_Previews: PreviewProvider {
    
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
            AccountCellView()
        })
            .previewDisplayName("Preview")
            .previewInterfaceOrientation(.portrait)
            .tint(Color.myGreenApple_light)
            .preferredColorScheme(.light)
        
    }
}

//MARK: HeaderviewCell component
struct HeaderviewCell: View {
    
    var acoounName: String
    var backgroundColor: Color
    
    var body: some View {
        HStack(alignment: .top) {
            Text(acoounName)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Image(systemName: "flag.fill")
                .foregroundColor(.red)
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
