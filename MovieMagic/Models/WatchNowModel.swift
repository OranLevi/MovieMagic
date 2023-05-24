//
//  WatchNowModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation

struct WatchNowModel: Decodable {
    let results: [WatchNowResult]?
}

// MARK: - Result
struct WatchNowResult: Identifiable, Decodable {
    let backdropPath: String?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
