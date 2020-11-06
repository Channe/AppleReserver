//
//  Region.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/8.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import Foundation

struct Region: Codable, Hashable {
    let code: String
    let name: String

    static let china = Region(code: "CN/zh_CN", name: "大陆")
    static let macau = Region(code: "MO/zh_MO", name: "澳门")
}
