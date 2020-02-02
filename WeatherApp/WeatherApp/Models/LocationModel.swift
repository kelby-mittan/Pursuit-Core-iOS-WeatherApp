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

//"confidence": 1,
//"formatted": "Los Angeles, CA, United States of America",
//"geometry": {
//    "lat": 34.0536909,
//    "lng": -118.2427666

