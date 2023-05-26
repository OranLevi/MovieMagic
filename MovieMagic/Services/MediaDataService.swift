//
//  MediaDataService.swift
//  MovieMagic
//
//  Created by Oran Levi on 24/05/2023.
//

import Foundation
import Combine

class MediaDataService {
    
    @Published var moviesArray: [MovieMagicResult] = []
    @Published var tvArray: [MovieMagicResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getMediaData(mediaType: .movie, page: 1)
        getMediaData(mediaType: .tv, page: 1)
    }
    
    func getMediaData(mediaType: MediaType, page: Int){
        
        let urlString = "https://api.themoviedb.org/3/discover/\(mediaType.rawValue)?page=\(page)&api_key=\(Constants.API_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        NetworkingManger.download(url: url)
            .decode(type: MovieMagicModel.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedMovies in
                self?.switchMediaType(mediaType: mediaType, returnedData: returnedMovies)
            }
            .store(in: &cancellables)
    }
    
    func switchMediaType(mediaType: MediaType, returnedData: MovieMagicModel){
        
        switch mediaType {
        case .movie:
            updateKindMedia(mediaType: .movie, array: &moviesArray, returnedData: returnedData)
        case .tv:
            updateKindMedia(mediaType: .tv, array: &tvArray, returnedData: returnedData)
        }
        
        func updateKindMedia(mediaType: MediaType,array: inout [MovieMagicResult], returnedData: MovieMagicModel) {
            let kindMedia: String?
            
            switch mediaType {
            case .movie:
                kindMedia = "movie"
            case .tv:
                kindMedia = "tv"
            }
            
            array += returnedData.results?.map { kindType in
                var updatedMovie = kindType
                updatedMovie.kindMedia = kindMedia
                return updatedMovie
            } ?? []
        }
    }
}
