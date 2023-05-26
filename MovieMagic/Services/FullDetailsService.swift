//
//  FullDetailsService.swift
//  MovieMagic
//
//  Created by Oran Levi on 25/05/2023.
//

import Foundation
import Combine

class FullDetailsService {
    
    @Published var fullDetails: [MovieMagicResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.fullDetails = fullDetails
    }
    
    func getFullDetails(mediaType: MediaType,id: Int){
        
        let urlString = "https://api.themoviedb.org/3/\(mediaType.rawValue)/\(id)?api_key=\(Constants.API_KEY)"
        
        guard let url = URL(string: urlString) else { return }
        NetworkingManger.download(url: url)
            .decode(type: MovieMagicResult.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedFullDetails in
                self?.fullDetails.append(returnedFullDetails)
            }
            .store(in: &cancellables)
    }
}
