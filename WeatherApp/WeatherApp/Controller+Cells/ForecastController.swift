//
//  ForecastController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastController: UIViewController {
    
    private let forecastView = ForecastView()
    
    override func loadView() {
        view = forecastView
    }
    
    var lat = 0.0 {
        didSet {
            print(lat)
        }
    }
    
    var long = 0.0 {
        didSet {
            print(long)
        }
    }
    
    var zipCodeString = "" {
        didSet {
            print(zipCodeString)
        }
    }
    
    //    var searchQuery = "" {
    //        didSet {
    //            DispatchQueue.main.async {
    ////                self.loadWeather()
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        getZip(search: "10019")
        
    }
    
    
    
    
    func getZip(search: String) {
        ZipCodeHelper.getLatLong(fromZipCode: search) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
                
            case .success(let latLong):
                self.lat = latLong.lat
                self.long = latLong.long
                self.zipCodeString = "\(latLong.lat),\(latLong.long)"
                //                print("\(self.lat.description),\(self.long.description)")
            }
        }
    }
    
    private func loadWeather() {
        
    }
    
}

