//
//  Accounts.swift
//  One Finance
//
//  Created by Tristan Stenuit on 04/09/2023.
//

import Foundation
import SwiftUI

class Acounts: ObservableObject {
    @Published public var accounts = [Account]()
    
    var isFavoriteFilter: [Account] {
        get {return accounts.filter{ $0.isFavorite }}
        set { accounts = accounts.filter{ $0.isFavorite }
            objectWillChange.send()
        }
    }
    
    var isMarkedFilter: [Account] {
        get {return accounts.filter{ $0.isMarked }}
        set { accounts = accounts.filter{ $0.isMarked }
            objectWillChange.send()
        }
    }
}
