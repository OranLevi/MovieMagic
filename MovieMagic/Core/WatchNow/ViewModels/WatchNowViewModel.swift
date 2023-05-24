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
    @Published var moviesPopularArray: [WatchNowResult] = []
    @Published var moviesUpcomingArray: [WatchNowResult] = []
    @Published var moviesTrendingArray: [WatchNowResult] = []
    @Published var moviesTopRatedArray: [WatchNowResult] = []
    
    // tv arrays
    @Published var tvPopularArray: [WatchNowResult] = []
    @Published var tvTrendingArray: [WatchNowResult] = []
    @Published var tvUpcomingArray: [WatchNowResult] = []
    
    // combine arrays
    var popularArray: [WatchNowResult] {
        return moviesPopularArray + tvPopularArray
    }
    
    var trendingArray: [WatchNowResult] {
        return moviesTrendingArray + tvTrendingArray
    }
    
    var upcomingArray: [WatchNowResult] {
        return moviesUpcomingArray + tvUpcomingArray
    }
    
    @Published var navBarArray: [String] = ["Populars","Upcoming","Trending","Top Rated"]
    @Published var selectedCategory: Int = 0 
    
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
                dataService.$tvUpcomingArray)
            .sink { [weak self] (returnedPopular,returnedTrending,returnedUpcoming) in
                self?.tvPopularArray = returnedPopular
                self?.tvTrendingArray = returnedTrending
                self?.tvUpcomingArray = returnedUpcoming
            }
            .store(in: &cancellables)
        
        
    }
}
