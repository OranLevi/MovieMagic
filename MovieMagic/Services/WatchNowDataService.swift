//
//  WatchNowDataService.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import Combine

enum MediaCategoryUrl: String {
    case moviePopular = "https://api.themoviedb.org/3/movie/popular?api_key="
    case movieTrending = "https://api.themoviedb.org/3/trending/movie/day?api_key="
    case movieUpcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key="
    case movieTopRated = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    case tvPopular = "https://api.themoviedb.org/3/tv/popular?api_key="
    case tvTrending = "https://api.themoviedb.org/3/trending/tv/day?api_key="
    case tvTopRated = "https://api.themoviedb.org/3/tv/top_rated?api_key="
}

class WatchNowDataService {
    
    // movies Arrays
    @Published var moviesPopularArray: [MovieMagicResult] = []
    @Published var moviesTrendingArray: [MovieMagicResult] = []
    @Published var moviesUpcomingArray: [MovieMagicResult] = []
    @Published var moviesTopRatedArray: [MovieMagicResult] = []
    
    // tv Arrays
    @Published var tvPopularArray: [MovieMagicResult] = []
    @Published var tvTrendingArray: [MovieMagicResult] = []
    @Published var tvTopRatedArray: [MovieMagicResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        // get movies data
        getData(mediaTypeUrl: .moviePopular, page: 1)
        getData(mediaTypeUrl: .movieTrending, page: 1)
        getData(mediaTypeUrl: .movieUpcoming, page: 1)
        getData(mediaTypeUrl: .movieTopRated, page: 1)
        
        // get tv data
        getData(mediaTypeUrl: .tvPopular, page: 1)
        getData(mediaTypeUrl: .tvTrending, page: 1)
        getData(mediaTypeUrl: .tvTopRated, page: 1)
    }
    
    func getData(mediaTypeUrl: MediaCategoryUrl, page: Int){
        
        let urlString = "\(mediaTypeUrl.rawValue)\(Constants.API_KEY)&page=\(page)"
        
        guard let url = URL(string: urlString) else { return }
        NetworkingManger.download(url: url)
            .decode(type: MovieMagicModel.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedMovies in
                self?.switchMediaType(mediaType: mediaTypeUrl, returnedMovies: returnedMovies)
                
            }
            .store(in: &cancellables)
    }
    
    func switchMediaType(mediaType: MediaCategoryUrl, returnedMovies: MovieMagicModel){
        
        switch mediaType {
        case .moviePopular:
            updateKindMedia(category: .moviePopular, array: &moviesPopularArray, returnedMovies: returnedMovies)
        case .movieTrending:
            updateKindMedia(category: .movieTrending, array: &moviesTrendingArray, returnedMovies: returnedMovies)
        case .movieUpcoming:
            updateKindMedia(category: .movieUpcoming, array: &moviesUpcomingArray, returnedMovies: returnedMovies)
        case .movieTopRated:
            updateKindMedia(category: .movieTopRated, array: &moviesTopRatedArray, returnedMovies: returnedMovies)
        case .tvPopular:
            updateKindMedia(category: .tvPopular, array: &tvPopularArray, returnedMovies: returnedMovies)
        case .tvTrending:
            updateKindMedia(category: .tvTrending, array: &tvTrendingArray, returnedMovies: returnedMovies)
        case .tvTopRated:
            updateKindMedia(category: .tvTopRated, array: &tvTopRatedArray, returnedMovies: returnedMovies)
        }
    }
    
    private func updateKindMedia(category: MediaCategoryUrl,array: inout [MovieMagicResult], returnedMovies: MovieMagicModel) {
        let kindMedia: String?
        
        switch category {
        case .moviePopular, .movieTrending, .movieUpcoming, .movieTopRated:
            kindMedia = "movie"
        case .tvPopular, .tvTrending, .tvTopRated:
            kindMedia = "tv"
        }
        
        array = returnedMovies.results?.map { kindtype in
            var updatedMovie = kindtype
            updatedMovie.kindMedia = kindMedia
            return updatedMovie
        } ?? []
    }
    
    
}
