//
//  Color.swift
//  MovieMagic
//
//  Created by Oran Levi on 21/05/2023.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
    let green = Color("green")
    let gray = Color("gray")
}
