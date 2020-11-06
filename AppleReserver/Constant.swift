//
//  Constant.swift
//  AppleReserver
//
//  Created by Sunnyyoung on 2017/9/19.
//  Copyright © 2017年 Sunnyyoung. All rights reserved.
//

import Foundation

struct Apple {
    static func store(of region: Region) -> URL {
        return URL(string: "https://reserve-prime.apple.com/\(region.code)/reserve/A/stores.json")!
    }

    static func availability(of region: Region, series: String) -> URL {
        return URL(string: "https://reserve-prime.apple.com/\(region.code)/reserve/\(series)/availability.json")!
    }
}
