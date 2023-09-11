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

class PaymentActivity: Identifiable, ObservableObject {
    var id = UUID()
    var name: String = ""
    var amount: Double = 0.0
    var date: Date?
    var type: TypePayement
    
    init(id: UUID = UUID(), name: String, amount: Double, date: Date? = nil, type: TypePayement) {
        self.id = id
        self.name = name
        self.amount = amount
        self.date = date
        self.type = type
    }
///WARING !!!
//    var formattedDate: String {
//        date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
//    }
}

