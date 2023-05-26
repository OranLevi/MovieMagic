//
//  SearchDataService.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import Foundation
import Combine

class SearchDataService {
    
    @Published var search: [MovieMagicResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    let textSearch: String
    
    init(textSearch: String) {
        self.textSearch = textSearch
        self.search = search
    }
    
    func getSearchData(textSearch: String){
        
        let urlString = "https://api.themoviedb.org/3/search/multi?api_key=\(Constants.API_KEY)&query=\(textSearch)"
        
        guard let url = URL(string: urlString) else { return }
        NetworkingManger.download(url: url)
            .decode(type: MovieMagicModel.self, decoder: JSONDecoder())
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedSearch in
                self?.search = returnedSearch.results ?? []
            }
            .store(in: &cancellables)
    }
}

