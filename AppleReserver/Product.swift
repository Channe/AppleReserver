//
//  Product.swift
//  AppleReserver
//
//  Created by Sunnyyoung on 2017/9/19.
//  Copyright © 2017年 Sunnyyoung. All rights reserved.
//

import Foundation

/**
 https://www.apple.com.cn/shop/product-locator-meta?family=iphone13
 
 {
 "productTitle": "iPhone 13 256GB 粉色",
 "basePartNumber": "MLE23",
 "image": "iphone-13-pink-select-2021",
 "dimensionCapacity": "256gb",
 "dimensionScreensize": "6_1inch",
 "price": "6799_00_unlocked",
 "partNumber": "MLE23CH/A",
 "productLink": "https://www.apple.com.cn/shop/buy-iphone/iphone-13/MLE23CH/A",
 "dimensionColor": "pink"
 }
 */
struct Product: Codable {
    let productTitle: String
    let basePartNumber: String
    let image: String
    let dimensionCapacity: String
    let dimensionScreensize: String
    let price: String
    let partNumber: String
    let productLink: String
    let dimensionColor: String
}
