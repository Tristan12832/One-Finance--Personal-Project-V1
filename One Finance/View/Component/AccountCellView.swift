//
//  AccountCellView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 26/08/2023.
//

import SwiftData
import SwiftUI

//MARK: AccountCellView
///Below are the components:
/// - HeaderviewCell component
/// - AmountViewCell component
/// - IconAccountCell component

struct AccountCellView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var account: Account
    
    var body: some View {
        ZStack {
            VStack(alignment:.center) {
                HeaderviewCell(acoounName: account.name, backgroundColor: .myGreen, isFavorite: $account.isFavorite, isMarked: $account.isMarked)
                Spacer()
                
                IconAccountCell(icon: account.icon, iconeColor: .primary)
                
                Spacer()
                
                AmountViewCell(amount: account.totalBalance, backgroundColor: .myGreen)
            }
            .fixedSize(horizontal: false, vertical: false)
            
        }
        .background(.backgroundColor4, in: .rect(cornerRadius: 8))
        .frame(maxWidth: 270, idealHeight: 420)
        .padding(4)
        .background(.backgroundColor3, in: .rect(cornerRadius: 8))
        .fixedSize(horizontal: false, vertical: true)
        .contextMenu {
            Button {
                withAnimation(.default) {
                    self.account.isFavorite.toggle()
                }
            } label: {
                Label(
                    account.isFavorite ? "Remove Favorite":"Mark Favorite",
                    systemImage: account.isFavorite ? "star.slash":"star")
            }
            
            Button {
                withAnimation(.default) {
                    self.account.isMarked.toggle()
                }
            } label: {
                Label(
                    account.isMarked ? "Remove Marked":"Mark Marked",
                    systemImage: account.isMarked ? "flag.slash":"flag")
            }
            
            Button(role: .destructive) {
                withAnimation(.default) {
                    modelContext.delete(account)
                }
            } label: {
                Label("Delete", systemImage: "trash")
                
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Account \(account.name) with icon of \(account.icon), and you have \(account.totalBalance).")
    }
}

//MARK: Preview
#Preview("Preview - Light Mode"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Test", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    return AccountCellView(account: account)
        .modelContainer(container)
        .preferredColorScheme(.light)
}

#Preview("Preview - Dark Mode"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Test", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    return AccountCellView(account: account)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}

#Preview("Preview + Sidebar", traits: .landscapeRight){
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Test", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    return NavigationSplitView {
        SidebarPreview()
    } detail: {
        AccountCellView(account: account)
    }
    .modelContainer(container)
    .preferredColorScheme(.dark)
}


//MARK: HeaderviewCell component
private struct HeaderviewCell: View {
    
    var acoounName: String
    var backgroundColor: Color
    @Binding var isFavorite: Bool
    @Binding var isMarked: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Text(acoounName)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            if isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
            if isMarked {
                Image(systemName: "flag.fill")
                    .foregroundStyle(.orange)
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
private struct AmountViewCell: View {
    
    var amount: Double
    var backgroundColor: Color
    
    var body: some View {
        Text(amount, format: .localCurrency)
            .foregroundStyle(.white)
            .font(.system(.largeTitle, design: .rounded, weight: .heavy))
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 80)
            .background(backgroundColor)
    }
}

//MARK: IconAccountCell component
private struct IconAccountCell: View {
    
    var icon: String
    var iconeColor: Color
    
    var body: some View {
        Image(systemName: icon)
            .foregroundStyle(iconeColor)
            .font(.system(size: 100))
            .fixedSize()
    }
}
