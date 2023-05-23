//
//  PosterImageViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import SwiftUI
import Combine

class PosterImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    let movie: MovieResult
    private let posterDataService: PosterImageService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(movie: MovieResult){
        self.movie = movie
        self.posterDataService = PosterImageService(movie: movie)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        posterDataService.$image
            .sink { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
