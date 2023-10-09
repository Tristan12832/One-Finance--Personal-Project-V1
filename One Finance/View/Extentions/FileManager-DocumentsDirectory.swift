//
//  FileManager-DocumentsDirectory.swift
//  One Finance
//
//  Created by Tristan Stenuit on 09/10/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
