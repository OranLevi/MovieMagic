//
//  MovieDataService.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import Combine

class MovieDataService {
    
    @Published var moviesArray: [MovieResult] = []
    
    var moviesSubscription: AnyCancellable?
    
    init(){
        getMoveis()
    }
    
    func getMoveis(){
        
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.API_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        moviesSubscription = NetworkingManger.download(url: url)
            .decode(type: MovieModel.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedMovies in
                self?.moviesArray = returnedMovies.results ?? []
                self?.moviesSubscription?.cancel()
            }
    }
}
