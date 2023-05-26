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
    
    let content: MovieMagicResult
    var imageSubscription: AnyCancellable?
    
    init(content: MovieMagicResult){
        self.content = content
        loadImage()
    }
    
    private func loadImage(){
        
        guard let posterPath = content.posterPath else {
            return
        }
        
        if let cachedImage = CacheManager.instance.get(name: posterPath) {
            self.image = cachedImage
        } else {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
                return
            }
            
            imageSubscription = NetworkingManger.download(url: url)
                .tryMap({ (data) -> UIImage? in
                    return UIImage(data: data)
                })
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    NetworkingManger.handleCompletion(completion: completion)
                } receiveValue: { [weak self] returnedImage in
                    if let image = returnedImage {
                        CacheManager.instance.addToCache(image: image, name: posterPath)
                    }
                    self?.image = returnedImage
                    self?.imageSubscription?.cancel()
                }
        }
    }
}
