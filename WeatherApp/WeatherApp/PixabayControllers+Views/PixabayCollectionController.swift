//
//  PixabayCollectionController.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence
import SafariServices

class PixabayCollectionController: UIViewController {

    private let pixView = PixabayCollectionView()
    
    public var persistence = DataPersistence<PixImage>(filename: "images.plist")
    
    var pixPics = [PixImage]() {
        didSet {
            DispatchQueue.main.async {
                self.pixView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = pixView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadPix()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pixView.collectionView.dataSource = self
        pixView.collectionView.delegate = self
        
        pixView.collectionView.register(UINib(nibName: "FavPixCell", bundle: nil), forCellWithReuseIdentifier: "pixCell")
//        loadPix()
        
    }
    
    private func loadPix() {
        do {
            pixPics = try persistence.loadItems()
        } catch {
            print("cannot load images")
        }
    }

}

extension PixabayCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pixPics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pixCell", for: indexPath) as? FavPixCell else {
            fatalError("could not downcast to FavPixCell")
        }
        let pixImage = pixPics[indexPath.row]
//        forecastDetailVC.pixDelegate = self
        
        cell.configureCell(for: pixImage)
        cell.backgroundColor = .white
        return cell
    }
}

extension PixabayCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.9
        return CGSize(width: itemWidth, height: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
        
        let webString = pixPics[indexPath.row].pageURL
        
        guard let url = URL(string: webString) else {
            print("no project url")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}

extension PixabayCollectionController: AddPixPicToCollection {
    func updateCollectionView(pixImage: PixImage) {
        pixPics.insert(pixImage, at: 0)
        do {
            try persistence.createItem(pixImage)
            
        } catch {
            print("could not create")
        }
    }
    
    
}
