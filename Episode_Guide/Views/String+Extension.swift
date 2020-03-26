//
//  String+Extension.swift
//  Episode_Guide
//
//  Created by Min Wu on 23/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {

    func value() -> String {
        if let value = self, value.uppercased() != "N/A" {
            return value
        }
        return ""
    }
}
