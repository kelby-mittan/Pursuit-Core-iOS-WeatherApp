//
//  ForecastDetailController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import NetworkHelper
import DataPersistence
import AVFoundation

protocol AddPhotoToFavorites: AnyObject {
    func updateCollectionView(pixImage: PixImage)
}

class ForecastDetailController: UIViewController {
    
    private let detailView = ForecastDetailView()
    public var dataPersistence: DataPersistence<PixImage>!
    public var forecast: DataObject?
    public var pixImage: PixImage?
    public var city: String?
    
    weak var pixDelegate: AddPhotoToFavorites!
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        detailView.savedLabel.isHidden = true
        
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
        
        guard let favPix = pixImage else { return }
        pixDelegate?.updateCollectionView(pixImage: favPix)
        
        do {
            guard let favPix = pixImage else { return }
            pixDelegate?.updateCollectionView(pixImage: favPix)
            try dataPersistence.createItem(favPix)
            
        } catch {
            print("could not save")
            showAlert(title: "Sorry", message: "This photo could not be favorited")
        }
        
        animateSavedPhoto()
    }
    
    private func animateSavedPhoto() {
        let duration: Double = 1.25
        let curveOption: UIView.AnimationOptions = .curveEaseInOut
        
        UIView.transition(with: detailView.cityImage, duration: duration, options: [.transitionFlipFromRight, curveOption], animations: {
            
            
        }) { (done) in
            self.detailView.savedLabel.isHidden = false
            self.detailView.cityImage.alpha = 0.35
        }
    }
    
}


