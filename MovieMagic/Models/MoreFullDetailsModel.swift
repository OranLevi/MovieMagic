//
//  MoreFullDetailsModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import Foundation

struct MoreFullDetailsModel : Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
