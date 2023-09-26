//
//  FileManager-DocumentsDirectory.swift
//  One Finance
//
//  Created by Tristan Stenuit on 17/09/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
