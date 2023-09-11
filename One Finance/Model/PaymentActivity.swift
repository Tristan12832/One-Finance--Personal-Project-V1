//
//  PayementActivity.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import Foundation

enum TypePayement: String {
    case income, expense
}

struct PaymentActivity: Identifiable {
    var id = UUID()
    var name: String = ""
    var amount: Double = 0.0
    var date: Date?
    var type: TypePayement
    
    var icon: String {
        let type = type
        switch type {
        case .income:
            return "arrowtriangle.up.circle.fill"
        case .expense:
            return "arrowtriangle.down.circle.fill"
        }
    }
//    init(id: UUID = UUID(), name: String, amount: Double, date: Date? = nil, type: TypePayement) {
//        self.id = id
//        self.name = name
//        self.amount = amount
//        self.date = date
//        self.type = type
//    }
///WARING !!!
//    var formattedDate: String {
//        date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
//    }
}

