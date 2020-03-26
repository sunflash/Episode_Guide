//
//  TVSeries.swift
//  Episode_Guide
//
//  Created by Min Wu on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation

struct TVSeries: Codable {

    let title: String?

    let seasons: [TVSeason]?
}

class Series: ObservableObject {
    
    @Published var title: String
    @Published var seasons: [TVSeason]

    init(fileName: String) {
        let series = DataSource.shared.getTVSeriesData(fileName)
        title = series?.title ?? ""
        seasons = series?.seasons ?? []
    }
}
