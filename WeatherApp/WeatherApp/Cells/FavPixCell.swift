//
//  FavPixCell.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavPixCell: UICollectionViewCell {
    
    @IBOutlet var favImage: UIImageView!
    
    public func configureCell(for pix: PixImage) {
        favImage.getImage(with: pix.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure:
                self?.favImage.image = UIImage(named: "lightningImage")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favImage.image = image
                }
            }
        }
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 10
    }
}
