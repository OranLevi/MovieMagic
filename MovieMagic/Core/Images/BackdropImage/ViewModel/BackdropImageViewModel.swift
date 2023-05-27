//
//  BackdropImageViewModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import Foundation
import SwiftUI
import Combine

class BackdropImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private let backdropDataService: BackdropImageService
    
    private var cancellables = Set<AnyCancellable>()
    
    let backdropPathUrl: String
    
    init(backdropPathUrl: String) {
        self.backdropPathUrl = backdropPathUrl
        self.backdropDataService = BackdropImageService(backdropPathUrl: backdropPathUrl)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        backdropDataService.$image
            .sink { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
