//
//  Target.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/8.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import Foundation

struct Target: Hashable {
    let region: Region
    let store: Stores.Store
    let product: Product

    var available: Bool?
}
