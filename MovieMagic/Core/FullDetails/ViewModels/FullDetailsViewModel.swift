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
    @Published var moreFullDetails: [MoreFullDetailsModel] = []
    
    private let fullDetailsDataService = FullDetailsService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        fullDetailsDataService.$fullDetails
            .sink { [weak self] (data) in
                let mappedDetails = data.flatMap { fullDetail -> [MoreFullDetailsModel] in
                    var moreFullDetailArray: [MoreFullDetailsModel] = []
                    
                    let releaseDate = MovieMagic.MoreFullDetailsModel(title: "Release date", value: fullDetail.releaseDate ?? fullDetail.firstAirDate ?? "N/A")
                    let status = MovieMagic.MoreFullDetailsModel(title: "Status", value: fullDetail.status ?? "N/A")
                    let originalLanguage = MovieMagic.MoreFullDetailsModel(title: "Language", value: fullDetail.originalLanguage ?? "N/A")
                    
                    moreFullDetailArray.append(contentsOf: [
                        releaseDate, status, originalLanguage
                    ])
                    
                    return moreFullDetailArray
                }
                
                self?.fullDetails = data
                self?.moreFullDetails = mappedDetails
            }
            .store(in: &cancellables)
    }
    
    //get full detail about selected movie / tv
    func loadDetails(mediaType: MediaType, id: Int){
        fullDetailsDataService.getFullDetails(mediaType: mediaType, id: id)
    }
    
}
