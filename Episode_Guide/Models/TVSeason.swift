//
//  TVSeason.swift
//  Episode_Guide
//
//  Created by Min Wu on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation

struct TVSeason: Codable {

    let episodes: [TVEpisode]?

    var seasonNumber: String {
        return episodes?.first?.season ?? ""
    }
}

extension TVSeason: Identifiable {
    var id: String {
        return episodes?.first?.season ?? UUID().uuidString
    }
}
