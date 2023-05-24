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
    
    let watchNow: WatchNowResult
    private let posterDataService: PosterImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(watchNow: WatchNowResult){
        self.watchNow = watchNow
        self.posterDataService = PosterImageService(watchNow: watchNow)
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
