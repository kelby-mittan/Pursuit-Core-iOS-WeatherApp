//
//  LocationAPIClient.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct LocationAPIClient {
    
    static func getLatLong(for city: String, completion: @escaping (Result<City, AppError>) -> ()) {
        
        
        let pixEndpointURL = "https://api.opencagedata.com/geocode/v1/json?q=\(city)&key=\(APIKey.cageKey)"
        
        guard let url = URL(string: pixEndpointURL) else {
            completion(.failure(.badURL(pixEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let citySearch = try JSONDecoder().decode(CitySearch.self, from: data)
                    let city = citySearch.results.first
                    completion(.success(city!))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
