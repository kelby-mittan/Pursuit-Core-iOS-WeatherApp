//
//  PixAPIClient.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct PixAPIClient {
    
    static func getPix(for city: String, completion: @escaping (Result<[PixImage], AppError>) -> ()) {
        
        let pixEndpointURL = "https://pixabay.com/api/?key=\(APIKey.pixKey)&q=\(city)&image_type=photo&per_page=120"
        
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
                    let pixSearch = try JSONDecoder().decode(PixSearch.self, from: data)
                    let pixHits = pixSearch.hits
                    completion(.success(pixHits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
