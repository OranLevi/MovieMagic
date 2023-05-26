//
//  WatchNowViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import Combine

enum selectedCategoryNames: Int{
    case populars = 0
    case upcoming = 1
    case trending = 2
    case topRated = 3
}

class WatchNowViewModel: ObservableObject {
    
    // movies arrays
    @Published var moviesPopularArray: [MovieMagicResult] = []
    @Published var moviesUpcomingArray: [MovieMagicResult] = []
    @Published var moviesTrendingArray: [MovieMagicResult] = []
    @Published var moviesTopRatedArray: [MovieMagicResult] = []
    
    // tv arrays
    @Published var tvPopularArray: [MovieMagicResult] = []
    @Published var tvTrendingArray: [MovieMagicResult] = []
    @Published var tvTopRatedArray: [MovieMagicResult] = []
    
    // combine arrays
    var popularArray: [MovieMagicResult] {
        return moviesPopularArray + tvPopularArray
    }
    
    var trendingArray: [MovieMagicResult] {
        return moviesTrendingArray + tvTrendingArray
    }
    
    var upcomingArray: [MovieMagicResult] {
        return moviesUpcomingArray + tvTopRatedArray
    }
    
    @Published var navBarArray: [String] = ["Populars","Upcoming","Trending","Top Rated"]
    @Published var selectedCategory: Int = 0
    
    @Published var selectedItemId:Int = 0
    @Published var selectedKindMedia: MediaType = .movie
    
    private let dataService = WatchNowDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        // moveis
        dataService.$moviesPopularArray
            .combineLatest(
                dataService.$moviesTrendingArray,
                dataService.$moviesUpcomingArray,
                dataService.$moviesTopRatedArray)
            .sink { [weak self] (returnedPopular,returnedTrending,returnedUpcoming,returnedTopRated) in
                self?.moviesPopularArray = returnedPopular
                self?.moviesTrendingArray = returnedTrending
                self?.moviesUpcomingArray = returnedUpcoming
                self?.moviesTopRatedArray = returnedTopRated
            }
            .store(in: &cancellables)
        
        //tv
        dataService.$tvPopularArray
            .combineLatest(
                dataService.$tvTrendingArray,
                dataService.$tvTopRatedArray)
            .sink { [weak self] (returnedPopular,returnedTrending,returnedTopRated) in
                self?.tvPopularArray = returnedPopular
                self?.tvTrendingArray = returnedTrending
                self?.tvTopRatedArray = returnedTopRated
            }
            .store(in: &cancellables)
        
    }
}
