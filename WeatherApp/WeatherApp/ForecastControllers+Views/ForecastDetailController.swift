//
//  ForecastDetailController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastDetailController: UIViewController {

    private let detailView = ForecastDetailView()
    
    public var forecast: Data?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
    }
    

    

}
