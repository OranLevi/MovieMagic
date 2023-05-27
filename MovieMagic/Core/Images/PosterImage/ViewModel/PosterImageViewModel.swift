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
    @Published var isLoading: Bool = true
    
    let content: MovieMagicResult
    private let posterDataService: PosterImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(content: MovieMagicResult){
        self.content = content
        self.posterDataService = PosterImageService(content: content)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        posterDataService.$image
            .sink(receiveCompletion: { [weak self] (_) in
                self?.isLoading = false
            }, receiveValue: {[weak self] returnedImage in
                self?.image = returnedImage
            })
        
            .store(in: &cancellables)
    }
}
