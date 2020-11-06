//
//  Product.swift
//  AppleReserver
//
//  Created by Sunnyyoung on 2017/9/19.
//  Copyright © 2017年 Sunnyyoung. All rights reserved.
//

import Foundation

struct Product: Codable, Hashable {
    enum Subfamily: String, Codable, Hashable {
        case iPhone12 = "iPhone 12"
        case iPhone12Pro = "iPhone 12 Pro"
        case iPhone12ProMax = "iPhone 12 Pro Max"
    }

    let partNumber: String
    let description: String
    let capacity: String
    let image: URL
    let subfamily: Subfamily

    var subfamilyCode: String {
        switch subfamily {
        case .iPhone12:
            return "F"
        case .iPhone12Pro:
            return "A"
        case .iPhone12ProMax:
            return "G"
        }
    }
}
