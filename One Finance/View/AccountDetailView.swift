//
//  AccountDetailView.swift
//  One Finance
//
//  Created by Tristan Stenuit on 30/08/2023.
//

import SwiftUI

//MARK: AccountCellView
///Below are the components:
/// - AmountView component
/// 
struct AccountDetailView: View {
    
    @StateObject var model = ExampleAccounts()

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Text("Account: \(model.example_Accounts[0].name)")
                    .font(.system(size: 40, weight: .bold, design: .default))
                .padding(.horizontal, 30)
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                AmountView(title: "Total Account", amount: model.example_Accounts[0].totalBalance, backgroundColor: .myGreenApple_light)
                
                HStack(spacing: 16){
                    AmountView(title: "Income", amount: model.example_Accounts[0].totalIncome, backgroundColor: .complementaryColor_light)
                    AmountView(title: "Expense", amount: model.example_Accounts[0].totalExpense, backgroundColor: .red)
                }
            }
            .padding(.horizontal, 30)
            .fixedSize(horizontal: false, vertical: true)
            
            //MARK: LIST
            VStack(spacing: 0) {
                VStack(spacing: 2){
                    HStack(alignment: .center) {
                        Text("Detail")
                            .font(.system(.title, design: .rounded, weight: .bold))
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundColor(.myGreenApple_light)

                    }
                    //MARK: Detail
                    HStack(alignment: .top) {
                        Group {
                            Text("All")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(.myGreenApple_light)
                                .onTapGesture {
                                    //FUTUR
                                }
                            Text("Income")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(.complementaryColor_light)
                                .onTapGesture {
                                    //FUTUR
                                }
                            Text("Expense")
                                .padding(3)
                                .padding(.horizontal, 10)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .onTapGesture {
                                    //FUTUR
                                }
                        }
                        .font(.system(.headline, design: .rounded))
                        .cornerRadius(8)
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                
                ForEach(model.example_Accounts.indices) { index in
                    PayementActivityCell(icon: "arrowtriangle.up.circle.fill", nameActivity: model.example_Accounts[1].payements[index].name, amount: model.example_Accounts[1].payements[index].amount)
                }
                .padding(1)
             }
            .padding(.vertical, 30)
            .padding(.horizontal, 30)
        }
        .toolbarBackground(Color.lightBackground5)
        .background(.lightBackground5)

    }
}

//MARK: Preview
struct HeaderAccountView_Previews: PreviewProvider {
    
    ///init the sidebar to display on "Preview"
    struct SidebarPreview: View {
        @State private var selection: Panel? = Panel.dashboard
        var body: some View {
            Sidebar(selection: $selection)
        }
    }
    
    static var previews: some View {
        NavigationSplitView {
            SidebarPreview()
        } detail: {
            AccountDetailView()
        }
        .previewDisplayName("Preview")
        .previewInterfaceOrientation(.landscapeRight)
        .tint(.myGreenApple_light)
        
        NavigationSplitView {
            NavigationStack{
                SidebarPreview()
            }
        } detail: {
            AccountDetailView()
        }
        .previewDevice("iPhone 14")
        .previewDisplayName("Preview iPhone")
        .previewInterfaceOrientation(.portrait)
        .tint(.myGreenApple_light)
        
    }
}

//MARK: AmountView component
struct AmountView: View {
    
    var title: String
    var amount: Double
    var backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
            Text(amount, format: .localCurrency)
        }
        .padding(.horizontal, 5)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 100)
        .font(.system(.largeTitle, design: .rounded, weight: .bold))
        .foregroundColor(.white)
        .background(backgroundColor)
        .cornerRadius(8)
        
    }
}
