//
//  FavPixCell.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    func didLongPress(_ imageCell: FavPixCell)
}

class FavPixCell: UICollectionViewCell {
    
    @IBOutlet var favImage: UIImageView!
    
    weak var delegate: ImageCellDelegate?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGestureRecognizer(longPressGesture)
    }
    
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
    
    @objc private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        delegate?.didLongPress(self)
    }
}
