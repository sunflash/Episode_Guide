//
//  Data.swift
//  Episode_Guide
//
//  Created by Min Wu on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation

struct DataSource {

    static let shared = DataSource()

    func getTVSeriesData(_ fileName: String) -> TVSeries? {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: filePath),
            let series = try? JSONDecoder().decode(TVSeries.self, from: data) else {
                return nil
        }
        return series
    }
}
