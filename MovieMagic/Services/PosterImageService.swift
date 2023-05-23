//
//  PosterImageService.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import SwiftUI
import Combine

class PosterImageService {
    
    @Published var image: UIImage? = nil
    
    let movie: MovieResult
    var imageSubscription: AnyCancellable?
    
    init(movie: MovieResult){
        self.movie = movie
        downloadImage()
    }
    
    private func downloadImage(){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")") else { return }
        print(url)
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManger.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
    }
}
