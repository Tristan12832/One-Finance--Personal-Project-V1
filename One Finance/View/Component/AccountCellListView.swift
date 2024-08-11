//
//  AccountCellListView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 29/08/2023.
//
import SwiftData
import SwiftUI

//MARK: AccountCellListView
///Below are the components:
/// - IconViewAccountListViewCell component
/// - InfoAccountViewCell component


struct AccountCellListView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var account: Account
    
    var body: some View {
        HStack {
            IconViewAccountListViewCell(icon: account.icon)
            
            InfoAccountViewCell(acoounName: account.name, amount: account.totalBalance, backgroundColor: .backgroundColor5)
            
            Spacer()
            
            //MARK: FAVORI and MARK
            HStack(spacing: 5) {
                if account.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(.title2, weight: .semibold))
                }
                
                if account.isMarked {
                    Image(systemName: "flag.fill")
                        .foregroundStyle(.orange)
                        .font(.system(.title2, weight: .semibold))
                }
            }
            .padding(.horizontal, 5)
        }
        .padding()
        .background(.backgroundColor4)
        .padding(8)
        .background(.myGreen, in: .rect(cornerRadius: 8))
        .background(Color.backgroundColor5)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(.backgroundColor5, lineWidth: 6)
        }
        .fixedSize(horizontal: false, vertical: true)
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                modelContext.delete(account)
            } label: {
                Label("Delete", systemImage: "trash")

            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false){
            
            Button {
                self.account.isMarked.toggle()
            } label: {
                HStack {
                    Text(account.isMarked ? "Remove from marked" : "Mark as marked")
                    Image(systemName: account.isMarked ? "flag.slash":"flag")
                }
            }
            .tint(.orange)
            Button {
                self.account.isFavorite.toggle()
            } label: {
                HStack {
                    Text(account.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: account.isFavorite ? "star.slash":"star")
                }
            }
            .tint(.yellow)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Account \(account.name) with icon of \(account.icon), and you have \(account.totalBalance, format: .localCurrency).")
        
    }
}


//MARK: Preview
#Preview("AccountCellListView - Light Mode"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Account", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    return NavigationStack {
        AccountCellListView(account: account)
    }
    .tint(Color.myGreen)
    .preferredColorScheme(.light)
    .modelContainer(container)
}

#Preview("AccountCellListView - Dark Mode"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Account", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    return NavigationStack {
        AccountCellListView(account: account)
    }
    .tint(Color.myGreen)
    .preferredColorScheme(.dark)
    .modelContainer(container)
}

#Preview("Preview With Sidebar -Portrait", traits: .portrait) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Account", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    
    return NavigationSplitView {
        NavigationStack {
            SidebarPreview()
        }
    } detail: {
        List {
            ForEach(0..<10) { _ in
                AccountCellListView(account: account)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
    .modelContainer(container)
    .preferredColorScheme(.light)
}

#Preview("Preview With Sidebar -landscapeLeft", traits: .landscapeRight) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Account", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    
    return NavigationSplitView {
        NavigationStack {
            SidebarPreview()
        }
    } detail: {
        List {
            ForEach(0..<10) { _ in
                AccountCellListView(account: account)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
    .modelContainer(container)
    .preferredColorScheme(.light)
}

#Preview("Preview With Sidebar -landscapeLeft & Dark Mode", traits: .landscapeRight) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)
    let account = Account(name: "Account", icon: "house.fill", payments: [], isFavorite: false, isMarked: false)
    
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.accounts
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    
    return NavigationSplitView {
        NavigationStack {
            SidebarPreview()
        }
    } detail: {
        List {
            ForEach(0..<10) { _ in
                AccountCellListView(account: account)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
    .modelContainer(container)
    .preferredColorScheme(.dark)
}

//MARK: IconViewAccountListViewCell component
struct IconViewAccountListViewCell: View {
    
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundStyle(.primary)
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
