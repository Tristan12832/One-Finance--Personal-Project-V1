//
//  PayementActivity.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import SwiftData
import SwiftUI


/// Enumeration to define payment types
///
/// This enumeration differentiates between types of payments: "income" and "expense".
enum TypePayement: String, RawRepresentable, CaseIterable, Codable {
    case income = "income"
    case expense = "expense"
}

@Model class PaymentActivity {
    let id = UUID()
    @Attribute(.unique) let name: String = ""
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

// Extension of the PaymentActivity class to add computed properties
extension PaymentActivity {
    
    /// Computed property to get the icon corresponding to the type of payment activity.
    /// - Returns: A string representing the name of the SF Symbols icon.
    var icon: String {
        let type = type
        switch type {
        case .income:
            return "arrowtriangle.up.circle.fill"
        case .expense:
            return "arrowtriangle.down.circle.fill"
        }
    }
    
    
    /// Computed property to get the color corresponding to the type of payment activity.
    /// - Returns: A SwiftUI color representing the color associated with the payment type.
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
