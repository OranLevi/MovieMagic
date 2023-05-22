//
//  WatchNowViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation

class WatchNowViewModel: ObservableObject {
    
    @Published var navBarArray: [String] = ["Populars","Upcoming","Trending","Top Rated"]
    
    @Published var selectedCategory: Int = 0
}
