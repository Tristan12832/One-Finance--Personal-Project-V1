//
//  Color-Theme.swift
//  One Finance
//
//  Created by Tristan Stenuit on 26/08/2023.
//

import Foundation
import SwiftUI


extension ShapeStyle where Self == Color {

    //MARK: My color accent
    static var myGreenApple_light: Color {
        Color(red: 0.0, green: 0.56, blue: 0.0)
    }
    
    static var myGreenApple_dark: Color {
        Color(red: 0.38, green: 0.68, blue: 0.0)
    }
    
    //MARK: Complementary color
    static var complementaryColor_light: Color {
        Color(red: 0.07, green: 0.29, blue: 0.69)
    }
    
    static var complementaryColor_dark: Color {
        Color(red: 0.22, green: 0.50, blue: 1)
    }
    
    //MARK: Light Them
    static var lightBackground1: Color {
        Color(red: 0.24, green: 0.24, blue: 0.26)
    }
    
    static var lightBackground2: Color {
        Color(red: 0.43, green: 0.44, blue: 0.47)
    }
    
    static var lightBackground3: Color {
        Color(red: 0.64, green: 0.65, blue: 0.68)
    }
    
    static var lightBackground4: Color {
        Color(red: 0.84, green: 0.85, blue: 0.86)
    }

    static var lightBackground5: Color {
        Color(red: 0.89, green: 0.90, blue: 0.91)
    }
    
    //MARK: Dark Them
    static var darkBackground1: Color {
        Color(red: 0.04, green: 0.16, blue: 0.35)
    }
    
    static var darkBackground2: Color {
        Color(red: 0.04, green: 0.13, blue: 0.29)
    }
    
    static var darkBackground3: Color {
        Color(red: 0.03, green: 0.10, blue: 0.22)
    }
    
    static var darkBackground4: Color {
        Color(red: 0.02, green: 0.07, blue: 0.18)
    }
    
    static var darkBackground5: Color {
        Color(red: 0.01, green: 0.03, blue: 0.07)
    }
}
