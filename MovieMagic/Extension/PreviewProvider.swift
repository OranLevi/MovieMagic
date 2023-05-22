//
//  PreviewProvider.swift
//  MovieMagic
//
//  Created by Oran Levi on 21/05/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()

    private init() {}
}
