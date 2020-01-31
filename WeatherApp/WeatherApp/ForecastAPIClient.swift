//
//  ForecastAPIClient.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct ForecastAPIClient {
    
    static func getForecast(for search: String, completion: @escaping (Result<[Data],AppError>) -> ()) {
        
        let playerEndpointString = "https://api.darksky.net/forecast/\(APIKey.weatherKey)/\(search)"
        
        guard let url = URL(string: playerEndpointString) else {
            completion(.failure(.badURL(playerEndpointString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    let forecast = weatherData.daily.data
                    completion(.success(forecast))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
