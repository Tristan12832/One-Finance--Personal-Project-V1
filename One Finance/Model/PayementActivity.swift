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

struct PayementActivity: Identifiable {
    var id = UUID()
    let name: String
    let amount: Double
    let date: Date?
    let type: TypePayement
///WARING !!!
//    var formattedDate: String {
//        date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
//    }
}

