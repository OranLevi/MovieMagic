//
//  MediaViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 24/05/2023.
//

import Foundation
import Combine

class MediaViewModel: ObservableObject {
    
    @Published var moviesArray: [MovieMagicResult] = []
    @Published var tvArray: [MovieMagicResult] = []
    
    private let dataService = MediaDataService()
    private var cancellables = Set<AnyCancellable>()
    var count = 1
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$moviesArray
            .combineLatest(dataService.$tvArray)
            .sink {[weak self] (returnMovies,returnTv ) in
                self?.moviesArray = returnMovies
                self?.tvArray = returnTv
            }
            .store(in: &cancellables)
    }
    
    func loadMore(mediaType: MediaDataService.MediaType){
        count += 1
        dataService.getMediaData(mediaType: mediaType, page: count)
        addSubscribers()
    }
}
