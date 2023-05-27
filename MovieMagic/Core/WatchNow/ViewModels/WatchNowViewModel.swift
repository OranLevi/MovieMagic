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
    
    @Published var isLoadingMore = false
    
    @Published var navBarArray: [String] = ["Populars","Upcoming","Trending","Top Rated"]
    @Published var selectedCategory: Int = 0
    
    @Published var selectedItemId:Int = 0
    @Published var selectedKindMedia: MediaType = .movie
    
    private let dataService = WatchNowDataService()
    private var cancellables = Set<AnyCancellable>()
    
    // page count to next/previous page
    var pageCountPopulars = 1
    var pageCountUpcoming = 1
    var pageCountTrending = 1
    var pageCountTopRated = 1
    
    // combine arrays
    var popularArray: [MovieMagicResult] {
        return moviesPopularArray + tvPopularArray
    }
    
    var trendingArray: [MovieMagicResult] {
        return moviesTrendingArray + tvTrendingArray
    }
    
    var upcomingArray: [MovieMagicResult] {
        return moviesUpcomingArray
    }
    
    var topRatedArray: [MovieMagicResult] {
        return moviesTopRatedArray + tvTopRatedArray
    }
    
    var hasData: Bool {
        if selectedCategory == selectedCategoryNames.populars.rawValue {
            return !popularArray.isEmpty
        } else if selectedCategory == selectedCategoryNames.upcoming.rawValue {
            return !upcomingArray.isEmpty
        } else if selectedCategory == selectedCategoryNames.trending.rawValue {
            return !trendingArray.isEmpty
        } else if selectedCategory == selectedCategoryNames.topRated.rawValue {
            return !topRatedArray.isEmpty
        } else {
            return false
        }
    }
    
    // disable Previous Button
    var disablePreviousButton: Bool {
        switch selectedCategory {
        case selectedCategoryNames.populars.rawValue:
            return pageCountPopulars == 1 ? true : false
        case selectedCategoryNames.trending.rawValue:
            return pageCountTrending == 1 ? true : false
        case selectedCategoryNames.upcoming.rawValue:
            return pageCountUpcoming == 1 ? true : false
        case selectedCategoryNames.topRated.rawValue:
            return pageCountTopRated == 1 ? true : false
        default:
            return true
        }
    }
    
    // array to show after select category
    var arrayToShow: [MovieMagicResult] {
        if selectedCategory == selectedCategoryNames.populars.rawValue {
            return popularArray
        } else if selectedCategory == selectedCategoryNames.upcoming.rawValue {
            return upcomingArray
        } else if selectedCategory == selectedCategoryNames.trending.rawValue {
            return trendingArray
        } else if selectedCategory == selectedCategoryNames.topRated.rawValue {
            return topRatedArray
        } else {
            return []
        }
    }
    
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
                self?.isLoadingMore = false
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
                self?.isLoadingMore = false
            }
            .store(in: &cancellables)
        
    }
    
    // update page count every category + get data
    func loadMore(MediaCategoryUrl: MediaCategoryUrl?, selectedCategory: Int, nextPage: Bool){
        if selectedCategory == selectedCategoryNames.populars.rawValue {
            nextPage ? (pageCountPopulars += 1) : (pageCountPopulars -= 1)
            dataService.getData(mediaTypeUrl: .moviePopular, page: pageCountPopulars)
            dataService.getData(mediaTypeUrl: .tvPopular, page: pageCountPopulars)
        } else if selectedCategory == selectedCategoryNames.upcoming.rawValue {
            nextPage ? (pageCountUpcoming += 1) : (pageCountUpcoming -= 1)
            dataService.getData(mediaTypeUrl: .movieUpcoming, page: pageCountUpcoming)
        } else if selectedCategory == selectedCategoryNames.trending.rawValue {
            nextPage ? (pageCountTrending += 1) : (pageCountTrending -= 1)
            dataService.getData(mediaTypeUrl: .movieTrending, page: pageCountTrending)
            dataService.getData(mediaTypeUrl: .tvTrending, page: pageCountTrending)
        } else if selectedCategory == selectedCategoryNames.topRated.rawValue {
            nextPage ? (pageCountTopRated += 1) : (pageCountTopRated -= 1)
            dataService.getData(mediaTypeUrl: .tvTopRated, page: pageCountTopRated)
            dataService.getData(mediaTypeUrl: .movieTopRated, page: pageCountTopRated)
        } else {
            return
        }
    }
}
