//
//  WatchNowViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import Combine

class WatchNowViewModel: ObservableObject {
    
    @Published var moviesArray: [MovieResult] = []
    
    @Published var navBarArray: [String] = ["Populars","Upcoming","Trending","Top Rated"]
    @Published var selectedCategory: Int = 0
    
    private let moviesDataService = MovieDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
        
    }
    
    func addSubscribers(){
        moviesDataService.$moviesArray
            .sink { [weak self] returnedMovies in
                self?.moviesArray = returnedMovies
            }
            .store(in: &cancellables)
        
    }
}
