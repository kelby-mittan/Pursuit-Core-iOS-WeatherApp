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
    
    private var forecasts = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.forecastView.collectionView.reloadData()
            }
        }
    }
    
    var zipCodeString = "" {
        didSet {
            ForecastAPIClient.getForecast(for: zipCodeString) { (result) in
                switch result {
                case .failure(let appError):
                    print(appError)
                case .success(let forecasts):
                    self.forecasts = forecasts
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        forecastView.collectionView.dataSource = self
        forecastView.collectionView.delegate = self
        forecastView.zipTextField.delegate = self
        
        forecastView.collectionView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCell")
        view.backgroundColor = .gray
    }
    
    
    
    
    func getZip(search: String) {
        ZipCodeHelper.getLatLong(fromZipCode: search) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
                
            case .success(let latLong):
                self.zipCodeString = "\(latLong.lat),\(latLong.long)"
                self.forecastView.cityLabel.text = latLong.placeName
            }
        }
    }
    
    private func loadWeather() {
        
    }
    
}

extension ForecastController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? ForecastCell else {
            fatalError("could not downcast to ForecastCell")
        }
        let forecast = forecasts[indexPath.row]
        cell.configureCell(for: forecast)
        cell.backgroundColor = .white
        return cell
    }
}

extension ForecastController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let forecastDetailStoryboard = UIStoryboard(name: "ForecastDetail", bundle: nil)
//        guard let forecastDetailController = forecastDetailStoryboard.instantiateViewController(withIdentifier: "ForecastDetailController") as? ForecastDetailController else {
//            fatalError("could not downcast")
//        }
//        let forecast = forecasts[indexPath.row]
////        forecastDetailController.forecast = forecast
//        navigationController?.pushViewController(forecastDetailController, animated: true)
    }
}

extension ForecastController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        zipCodeString = text
        zipCodeString = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        zipCodeString = zipCodeString.replacingOccurrences(of: " ", with: "")
        
        getZip(search: zipCodeString)
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
}

