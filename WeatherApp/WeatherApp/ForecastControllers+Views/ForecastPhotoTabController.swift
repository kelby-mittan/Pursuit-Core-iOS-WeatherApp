//
//  ForecastPhotoTabController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastPhotoTabController: UITabBarController {
    
    public lazy var forecastVC: ForecastController = {
        let viewController = ForecastController()
        viewController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "1.circle"), tag: 0)
        return viewController
    }()
    
    public lazy var pixabayCollectionVC: PixabayCollectionController = {
        let viewController = PixabayCollectionController()
        viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "2.circle"), tag: 1)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [forecastVC, pixabayCollectionVC]
    }
    
    
    
}
