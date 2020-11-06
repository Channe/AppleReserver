//
//  Stores.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/6.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import Foundation

struct Stores: Codable, Hashable {
    struct Config: Codable, Hashable {
        let reservationURL: URL
    }

    struct Store: Codable, Hashable {
        let storeNumber: String
        let storeName: String
        let city: String
        let latitude: String
        let longitude: String
        let enabled: Bool
    }

    let config: Config
    let stores: [Store]
}
