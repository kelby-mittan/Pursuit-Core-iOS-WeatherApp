//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
//import ImageKit

class ForecastCell: UICollectionViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var forecastImage: UIImageView!
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var lowLabel: UILabel!
    
    func configureCell(for forecast: DataObject) {
        
        let timeDouble = Double(forecast.time)
        dateLabel.text = timeDouble.dateConverter()
        forecastImage.image = UIImage(named: forecast.icon)
        highLabel.text = "High: \(String(format: "%g", forecast.temperatureHigh.rounded()))\u{00B0}F"
        lowLabel.text = "Low: \(String(format: "%g", forecast.temperatureLow.rounded()))\u{00B0}F"
        pulsatingAnimation()
        layer.cornerRadius = 7
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func pulsatingAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.repeat,.autoreverse], animations: {

            self.forecastImage.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { (done) in
            
            UIView.animate(withDuration: 0.3) {
                self.forecastImage.transform = CGAffineTransform.identity
            }
        }
    }
    
}
