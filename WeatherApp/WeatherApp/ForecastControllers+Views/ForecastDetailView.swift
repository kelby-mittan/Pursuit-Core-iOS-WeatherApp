//
//  ForecastDetailView.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastDetailView: UIView {
    
    public var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for Weather!"
        label.textAlignment = .center
        //        label.font = UIFont(name: "Damascas", size: 20)
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    public lazy var cityImage: UIImageView = {
        let image = UIImageView()
        image.image = nil
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    public var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.textAlignment = .left
        //        label.font = UIFont(name: "Damascas", size: 20)
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    public var sunriseLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunrise"
        label.textAlignment = .left
        //        label.font = UIFont(name: "Damascas", size: 20)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    public var sunsetLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunset"
        label.textAlignment = .left
        //        label.font = UIFont(name: "Damascas", size: 20)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    public var highTempLabel: UILabel = {
        let label = UILabel()
        label.text = "High"
        label.textAlignment = .left
        //        label.font = UIFont(name: "Damascas", size: 20)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    public var lowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Low"
        label.textAlignment = .left
        //        label.font = UIFont(name: "Damascas", size: 20)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
//    public lazy var tabBar: ForecastPhotoTabController = {
//        let tab = ForecastPhotoTabController()
//        
//        return tab
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupCityLabelConstraints()
        setupCityImageConstraints()
        setupSummaryLabelConstraints()
        setupSunriseLabelConstraints()
        setupSunsetLabelConstraints()
        setupHighTempLabelConstraints()
        setupLowTempLabelConstraints()
    }
    
    private func setupCityLabelConstraints() {
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    
    
    private func setupCityImageConstraints() {
        addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            cityImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityImage.widthAnchor.constraint(equalTo: widthAnchor),
            cityImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupSummaryLabelConstraints() {
        addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSunriseLabelConstraints() {
        addSubview(sunriseLabel)
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunriseLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 15),
            sunriseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sunriseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSunsetLabelConstraints() {
        addSubview(sunsetLabel)
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 6),
            sunsetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sunsetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupHighTempLabelConstraints() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highTempLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 6),
            highTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            highTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupLowTempLabelConstraints() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 6),
            lowTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lowTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
