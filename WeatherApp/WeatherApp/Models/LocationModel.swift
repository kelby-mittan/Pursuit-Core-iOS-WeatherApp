//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct CitySearch: Codable {
    let results: [City]
}

struct City: Codable {
    
    let formatted: String
    let geometry: Geometry
    
}

struct Geometry: Codable {
    let lat: Double
    let lng: Double
}

//struct Alphabet {
//    static let alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
//}


