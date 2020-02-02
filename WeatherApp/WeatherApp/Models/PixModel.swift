//
//  PixModel.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct PixSearch: Codable {
    let hits: [PixImage]
}

struct PixImage: Codable & Equatable {
    
    let largeImageURL: String
    let pageURL: String
    let tags: String
    let imageSize: Int
//    let downloads: Int
//    let userImageURL: String
//    let previewURL: String
    
}
