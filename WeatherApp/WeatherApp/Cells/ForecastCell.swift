//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class ForecastCell: UICollectionViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var forecastImage: UIImageView!
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var lowLabel: UILabel!
    
    func configureCell(for forecast: Data) {
        
        let timeDouble = Double(forecast.time)
        
        dateLabel.text = timeDouble.timeConverter()
        
        forecastImage.image = UIImage(named: forecast.icon)
        
        highLabel.text = forecast.temperatureHigh.description
    }
    
}
