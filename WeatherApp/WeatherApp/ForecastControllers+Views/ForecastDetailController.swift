//
//  ForecastDetailController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
//import ImageKit
import NetworkHelper
import DataPersistence
import AVFoundation

class ForecastDetailController: UIViewController {
    
    private let detailView = ForecastDetailView()
    
    private let tabBar = ForecastPhotoTabController()
    
    public var persistence = DataPersistence<PixImage>(filename: "images.plist")
    
    public var forecast: DataObject?
    
    public var pixImage: PixImage?
    
    public var city: String?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePhoto))
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        updateUI()
        updateImage()
    }
    
    
    private func updateUI() {
        city = city?.replacingOccurrences(of: "%20", with: " ")
        let date = Double(forecast?.time ?? 0)
        detailView.cityLabel.text = "Weather Forecast for \(city ?? "N/A") on \(date.dateConverter())"
        
        detailView.summaryLabel.text = forecast?.summary
        
        var sunrise = Double(forecast?.sunriseTime ?? 0).timeConverter().description
        if sunrise.first == "0" {
            sunrise.remove(at: sunrise.startIndex)
        }
        detailView.sunriseLabel.text = "sunrise: \(sunrise)"
        
        var sunset = Double(forecast?.sunsetTime ?? 0).timeConverter().description
        if sunset.first == "0" {
            sunset.remove(at: sunset.startIndex)
        }
        detailView.sunsetLabel.text = "sunset: \(sunset)"
        
        detailView.highTempLabel.text = "high: \(String(format: "%g", forecast?.temperatureHigh.rounded() ?? 0))\u{00B0}F"
        detailView.lowTempLabel.text = "low: \(String(format: "%g", forecast?.temperatureLow.rounded() ?? 0))\u{00B0}F"
        
    }
    
    private func updateImage() {
        detailView.cityImage.contentMode = .scaleAspectFill
        
        guard let image = pixImage?.largeImageURL else { return }
        
        detailView.cityImage.getImage(with: image) { [weak self] (result) in
            switch result {
            case .failure:
                self?.detailView.cityImage.image = UIImage(named: "lightningImage")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.cityImage.image = image
                }
            }
        }
    }
    
    @objc func savePhoto(_ sender: UIBarButtonItem){
        print("clicked")
        sender.isEnabled = false
        do {
            guard let favPix = pixImage else { return }
            try persistence.createItem(favPix)
            showAlert(title: "Cool", message: "This photo has been favorited")
        } catch {
            print("could not save")
        }
    }
    
}


