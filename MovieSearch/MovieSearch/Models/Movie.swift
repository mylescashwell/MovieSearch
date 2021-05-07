//
//  Movie.swift
//  MovieSearch
//
//  Created by Myles Cashwell on 5/7/21.
//

import UIKit

struct TopLevelObject: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let description: String
    let rating: Double
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case description = "overview"
        case rating = "vote_average"
        case image = "poster_path"
    }
}
