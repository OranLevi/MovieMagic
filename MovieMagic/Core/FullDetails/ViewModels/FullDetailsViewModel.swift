//
//  FullDetailsViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 23/05/2023.
//

import Foundation
import Combine

class FullDetailsViewModel: ObservableObject {
    
    @Published var fullDetails: [MovieMagicResult] = []
    
    private let dataService = FullDetailsService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        dataService.$fullDetails
            .sink { [weak self] (returnedFullDetails) in
                self?.fullDetails = returnedFullDetails
            }
            .store(in: &cancellables)
    }
    
    func loadDetails(mediaType: MediaType, id: Int){
        dataService.getFullDetails(mediaType: mediaType, id: id)
        addSubscribers()
    }
}
