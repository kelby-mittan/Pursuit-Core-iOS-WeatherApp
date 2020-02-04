//
//  ForecastController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import CoreLocation
import DataPersistence

struct RecentSearchKey {
    static let zipOrCity = "Zip or City"
}

class ForecastController: UIViewController {
    
    private let forecastView = ForecastView()
    public var dataPersistence: DataPersistence<PixImage>!
    
    override func loadView() {
        view = forecastView
    }
    
    private var forecasts = [DataObject]() {
        didSet {
            DispatchQueue.main.async {
                self.forecastView.collectionView.reloadData()
            }
        }
    }
    
    private var zipCodeString = "" {
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
    
    private var cityFromZip = ""
    
    private var pixPics = [PixImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        forecastView.collectionView.dataSource = self
        forecastView.collectionView.delegate = self
        forecastView.zipTextField.delegate = self
        
        forecastView.collectionView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCell")
        view.backgroundColor = .black
        
        forecastView.rainGifImage.loadGif(name: "rainGIF")
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Weather Forecast"
        navigationController?.navigationBar.barTintColor = .black
        tabBarController?.tabBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont.init(name: "AvenirNext-DemiBold", size: 22.0)!]
        
    }
    
    func getZip(search: String) {
        ZipCodeHelper.getLatLong(fromZipCode: search) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
                
            case .success(let latLong):
                self.zipCodeString = "\(latLong.lat),\(latLong.long)"
                self.forecastView.cityLabel.text = latLong.placeName
                self.cityFromZip = latLong.placeName
                self.loadPix(for: latLong.placeName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
                self.forecastView.collectionView.isHidden = false
            }
        }
    }
    
    private func loadPix(for search: String) {
        PixAPIClient.getPix(for: search) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success(let pics):
                DispatchQueue.main.async {
                    self?.pixPics = pics
                }
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.308
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecastDetailVC = ForecastDetailController()
        let forecast = forecasts[indexPath.row]
        forecastDetailVC.forecast = forecast
        forecastDetailVC.city = cityFromZip
        forecastDetailVC.dataPersistence = dataPersistence
        
        let ranIndex = pixPics.count - 1
        
        if !pixPics.isEmpty {
            let pixImage = pixPics[Int.random(in: 0...ranIndex)]
            forecastDetailVC.pixImage = pixImage
        }
        navigationController?.pushViewController(forecastDetailVC, animated: true)
    }
}

extension ForecastController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        UserDefaults.standard.set(text, forKey: RecentSearchKey.zipOrCity)
        
        zipCodeString = text
        getZip(search: zipCodeString)
        
        forecastView.collectionView.isHidden = false
        forecastView.rainGifImage.isHidden = true
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
    
    
}


