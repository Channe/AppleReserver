//
//  Store.swift
//  AppleReserver
//
//  Created by Sunnyyoung on 2017/9/19.
//  Copyright © 2017年 Sunnyyoung. All rights reserved.
//

import Foundation

/**
 {
 "storeNumber": "R320",
 "city": "北京",
 "latitude": "39.933456",
 "storeName": "三里屯",
 "enabled": true,
 "longitude": "116.447967"
 }
 */
struct Store: Codable {
    let storeNumber: String?
    let storeName: String?
    let city: String?
    let latitude: String?
    let longitude: String?
    let enabled: Bool
}
