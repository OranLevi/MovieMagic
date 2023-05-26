//
//  PreviewProvider.swift
//  MovieMagic
//
//  Created by Oran Levi on 21/05/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let detail = MovieMagicModel(results: [MovieMagicResult(backdropPath: "", firstAirDate: "", name: "", id: 2, originalLanguage: "", originalTitle: "", originalName: "", overview: "", posterPath: "", releaseDate: "", title: "", popularity: 2, voteAverage: 2, voteCount: 3, kindMedia: "movie" )])
    
    let movie = MovieMagicResult(
        backdropPath: "/nLBRD7UPR6GjmWQp6ASAfCTaWKX.jpg",
        firstAirDate: "2023-05-05",
        name: "The Super Mario Bros. Movie",
        id: 502356,
        originalLanguage: "en",
        originalTitle: "The Super Mario Bros. Movie",
        originalName: "original Name",
        overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        releaseDate: "2023-04-05",
        title: "The Super Mario Bros. Movie",
        popularity: 2,
        voteAverage: 5,
        voteCount: 3049,
        kindMedia: "movie")
}
