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
        
    public var dataPersistence: DataPersistence<PixImage>!
    
    let forecastDetailVC = ForecastDetailController()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pixView.collectionView.dataSource = self
        pixView.collectionView.delegate = self
        
        pixView.collectionView.register(UINib(nibName: "FavPixCell", bundle: nil), forCellWithReuseIdentifier: "pixCell")

    }
    
    private func loadPix() {
        do {
            pixPics = try dataPersistence.loadItems().reversed()
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
        
        cell.delegate = self
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

extension PixabayCollectionController: ImageCellDelegate {
    func didLongPress(_ imageCell: FavPixCell) {
        print("delegate working")
        
        guard let indexPath = pixView.collectionView.indexPath(for: imageCell) else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(alertController, animated: true)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deleteImageObject(indexPath: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }
    
    private func deleteImageObject(indexPath: IndexPath) {
        do {
            try dataPersistence.deleteItem(at: indexPath.row)
            
            pixPics.remove(at: indexPath.row)
            
            pixView.collectionView.deleteItems(at: [indexPath])
            
        } catch {
            print("Error deleting")
        }
        
    }
}

extension PixabayCollectionController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
        loadPix()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
    
    
}
