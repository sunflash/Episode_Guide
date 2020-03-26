//
//  TVEpisode.swift
//  Episode_Guide
//
//  Created by MW on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation

struct TVEpisode: Codable {

    let season: String?

    let episode: String?

    let title: String?

    let plot: String?

    let poster: String?

    let genre: String?

    let type: String?

    let rated: String?

    let runtime: String?

    let language: String?

    let country: String?

    let year: String?

    let released: String?



    let seriesID: String?

    let imdbID: String?

    let imdbRating: String?

    let imdbVotes: String?

    let metaScore: String?

    let response: String?

    let ratings: [TVRating]?



    let awards: String?

    let director: String?

    let actors: String?

    let writer: String?



    enum CodingKeys: String, CodingKey {

        case season = "Season"

        case episode = "Episode"

        case title = "Title"

        case plot = "Plot"

        case poster = "Poster"

        case genre = "Genre"

        case type = "Type"

        case rated = "Rated"

        case runtime = "Runtime"

        case language = "Language"

        case country = "Country"

        case year = "Year"

        case released = "Released"

        case seriesID

        case imdbID

        case imdbRating

        case imdbVotes

        case metaScore = "Metascore"

        case response = "Response"

        case ratings = "Ratings"

        case awards = "Awards"

        case director = "Director"

        case actors = "Actors"

        case writer = "Writer"
    }
}

extension TVEpisode: Identifiable {

    var id: String {
        if let id = imdbID {
            return id
        } else if let season = season, let episode = episode {
            return "S\(season)E\(episode)"
        } else {
            return UUID().uuidString
        }
    }
}
