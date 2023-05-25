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
    
    enum MediaType: String {
        case movie
        case tv
    }
    
    init(){
        getMediaData(mediaType: .movie, page: 1)
        getMediaData(mediaType: .tv, page: 1)
    }
    
    func getMediaData(mediaType: MediaType, page: Int){
        
        let urlString = "https://api.themoviedb.org/3/discover/\(mediaType.rawValue)?page=\(page)&api_key=\(Constants.API_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        print(url)
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
        if mediaType == .movie {
            moviesArray += returnedData.results ?? []
        } else if mediaType == .tv {
            tvArray += returnedData.results ?? []
        }
    }
}
