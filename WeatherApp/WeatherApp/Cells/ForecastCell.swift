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
        highLabel.text = "High: \(forecast.temperatureHigh.description)"
        lowLabel.text = "Low: \(forecast.temperatureLow.description)"
        pulsatingAnimation()
        layer.cornerRadius = 7
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func pulsatingAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.repeat,.autoreverse], animations: {
            // animation block
            self.forecastImage.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { (done) in
            // code to be excecuted after animation is complete
            // options - you can reset views values
            // options - create another animation
            // if you want to go beyond creating an animation in this animation handler the better choice would be animateKeyFrames()
            
            UIView.animate(withDuration: 0.3) {
                self.forecastImage.transform = CGAffineTransform.identity
            }
        }
    }
    
}
