//
//  WatchNowDataService.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import Combine

class WatchNowDataService {
    
    // movies Arrays
    @Published var moviesPopularArray: [WatchNowResult] = []
    @Published var moviesTrendingArray: [WatchNowResult] = []
    @Published var moviesUpcomingArray: [WatchNowResult] = []
    @Published var moviesTopRatedArray: [WatchNowResult] = []
    
    // tv Arrays
    @Published var tvPopularArray: [WatchNowResult] = []
    @Published var tvTrendingArray: [WatchNowResult] = []
    @Published var tvUpcomingArray: [WatchNowResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    enum MediaType: String {
        case moviePopular = "https://api.themoviedb.org/3/movie/popular?api_key="
        case movieTrending = "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case movieUpcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key="
        case movieTopRated = "https://api.themoviedb.org/3/movie/top_rated?api_key="
        case tvPopular = "https://api.themoviedb.org/3/tv/popular?api_key="
        case tvTrending = "https://api.themoviedb.org/3/trending/tv/day?api_key="
        case tvTopRated = "https://api.themoviedb.org/3/tv/top_rated?api_key="
    }
    
    init(){
        // get movies data
        getData(mediaType: .moviePopular)
        getData(mediaType: .movieTrending)
        getData(mediaType: .movieUpcoming)
        getData(mediaType: .movieTopRated)
        
        // get tv data
        getData(mediaType: .tvPopular)
        getData(mediaType: .tvTrending)
        getData(mediaType: .tvTopRated)
    }
    
    private func getData(mediaType: MediaType){
        
        let urlString = "\(mediaType.rawValue)\(Constants.API_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        NetworkingManger.download(url: url)
            .decode(type: WatchNowModel.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedMovies in
                self?.switchMediaType(mediaType: mediaType, returnedMovies: returnedMovies)
            }
            .store(in: &cancellables)
    }
    
    func switchMediaType(mediaType: MediaType, returnedMovies: WatchNowModel){
        if mediaType == .moviePopular {
            moviesPopularArray = returnedMovies.results ?? []
        } else if mediaType == .movieTrending {
            moviesTrendingArray = returnedMovies.results ?? []
        } else if mediaType == .movieUpcoming {
            moviesUpcomingArray = returnedMovies.results ?? []
        } else if mediaType == .movieTopRated {
            moviesTopRatedArray = returnedMovies.results ?? []
        } else if mediaType == .tvPopular {
            tvPopularArray = returnedMovies.results ?? []
        } else if mediaType == .tvTrending {
            tvTrendingArray = returnedMovies.results ?? []
        } else if mediaType == .tvTopRated{
            tvPopularArray = returnedMovies.results ?? []
        }
    }
}
