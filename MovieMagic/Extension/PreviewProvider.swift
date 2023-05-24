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
    let detail = WatchNowModel(results: [WatchNowResult(backdropPath: "", id: 2, originalLanguage: "", originalTitle: "", overview: "", posterPath: "", releaseDate: "", title: "", voteAverage: 2, voteCount: 2)])
    
    let movie = WatchNowResult(
        backdropPath: "/nLBRD7UPR6GjmWQp6ASAfCTaWKX.jpg",
        id: 502356,
        originalLanguage: "en",
        originalTitle: "The Super Mario Bros. Movie",
        overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        releaseDate: "2023-04-05",
        title: "The Super Mario Bros. Movie",
        voteAverage: 7.7,
        voteCount: 3049
    )
}
