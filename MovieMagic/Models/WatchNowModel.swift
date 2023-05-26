//
//  WatchNowModel.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation

struct MovieMagicModel: Decodable {
    var results: [MovieMagicResult]?
}

// MARK: - Result
struct MovieMagicResult: Identifiable, Decodable {
    let backdropPath: String?
    let firstAirDate: String?
    let name: String?
    let id: Int?
    let originalLanguage, originalTitle, originalName, overview: String?
    let posterPath, releaseDate, title: String?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
    var kindMedia: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case id, name
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case originalName
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case kindMedia
    }
    
}
