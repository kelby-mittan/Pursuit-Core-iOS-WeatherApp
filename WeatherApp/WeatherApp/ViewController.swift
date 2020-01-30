//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        getZip(search: "10019")
        //        print(lat)
        //        print(long)
//        print("\(lat.description),\(long.description)")
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
    
}

