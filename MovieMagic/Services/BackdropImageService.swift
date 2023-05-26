//
//  BackdropImageService.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import Foundation
import SwiftUI
import Combine

class BackdropImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    let backdropPathUrl: String
    
    init(backdropPathUrl: String){
        self.backdropPathUrl = backdropPathUrl
        loadImage()
    }
    
    func loadImage(){
        
        let backdrop = backdropPathUrl
        
        if let cachedImage = CacheManager.instance.get(name: backdropPathUrl) {
            self.image = cachedImage
        } else {
            guard let url = URL(string: "https://image.tmdb.org/t/p/original/\(backdropPathUrl)") else { return }
            imageSubscription = NetworkingManger.download(url: url)
                .tryMap({ (data) -> UIImage? in
                    return UIImage(data: data)
                })
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    NetworkingManger.handleCompletion(completion: completion)
                } receiveValue: { [weak self] returnedImage in
                    if let image = returnedImage {
                        CacheManager.instance.addToCache(image: image, name: backdrop)
                    }
                    self?.image = returnedImage
                    self?.imageSubscription?.cancel()
                }
        }
    }
}
