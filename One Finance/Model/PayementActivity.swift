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
    let type: TypePayement
}
