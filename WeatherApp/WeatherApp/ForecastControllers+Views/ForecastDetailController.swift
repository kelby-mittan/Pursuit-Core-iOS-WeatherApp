//
//  ForecastDetailController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import NetworkHelper
import DataPersistence

class ForecastDetailController: UIViewController {
    
    private let detailView = ForecastDetailView()
    
    private let tabBar = ForecastPhotoTabController()
    
    public var forecast: Data?
    
    public var pixImage: PixImage?
    
    public var city: String?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        //        print(pixImage?.largeImageURL)
        
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePhoto))
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        updateUI()
    }
    
    
    private func updateUI() {
        city = city?.replacingOccurrences(of: "%20", with: " ")
        detailView.cityLabel.text = "Weather Forecast for \(city ?? "N/A")"
        detailView.summaryLabel.text = forecast?.summary
        detailView.cityImage.contentMode = .scaleAspectFill
        
        let sunrise = Double(forecast?.sunriseTime ?? 0)
        detailView.sunriseLabel.text = "sunrise: \(sunrise.timeConverter())"
        
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
    
    @objc func savePhoto(){
         print("clicked")
    }
    
}
