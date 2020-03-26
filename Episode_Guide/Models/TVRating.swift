//
//  TVRating.swift
//  Episode_Guide
//
//  Created by MW on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation

struct TVRating: Codable {

    let source: String?

    let value: String?

    enum CodingKeys: String, CodingKey {

        case source = "Source"

        case value = "Value"
    }
}
