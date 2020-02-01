//
//  ForecastPhotoTabController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastPhotoTabController: UITabBarController {

    private lazy var forecastVC: ForecastController = {
            let viewController = ForecastController()
            viewController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "1.circle"), tag: 0)
            return viewController
        }()
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            viewControllers = [forecastVC]
        }
    


}
