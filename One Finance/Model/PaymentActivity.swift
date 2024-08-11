//
//  PayementActivity.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftData
import SwiftUI

enum TypePayement: String, RawRepresentable, CaseIterable, Codable {
    case income = "income"
    case expense = "expense"
}

@Model class PaymentActivity {
    let id = UUID()
    let name: String = ""
    let amount: Double = 0.0
    let date: Date?
    let type: TypePayement
    var account: Account?
    
    
    init(name: String, amount: Double, date: Date? = nil, type: TypePayement) {
        self.name = name
        self.amount = amount
        self.date = date
        self.type = type
    }
    
}

extension PaymentActivity {
    var icon: String {
        let type = type
        switch type {
        case .income:
            return "arrowtriangle.up.circle.fill"
        case .expense:
            return "arrowtriangle.down.circle.fill"
        }
    }
    
    
    var color: Color {
        let type = type
        switch type {
        case .income:
            return Color.complementary
        case .expense:
            return Color.red
        }
    }
}
