//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let daily: Daily
}

struct Daily: Codable {
    let summary: String
    let data: [DataObject]
}

struct DataObject: Codable {
    let time: Int
    let summary: String
    let sunriseTime: Int
    let sunsetTime: Int
    let temperatureHigh: Double
    let temperatureLow: Double
    let icon: String
}
