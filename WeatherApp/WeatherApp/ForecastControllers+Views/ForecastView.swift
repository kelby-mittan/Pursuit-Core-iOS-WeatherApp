//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Kelby Mittan on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastView: UIView {

    public var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for Weather!"
        
        label.textAlignment = .center
        return label
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 200)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemTeal
        return cv
    }()
    
    public lazy var zipTextField: UITextField = {
        let text = UITextField()
//        text.placeholder = "Enter Zip Code"
        
        text.setAttributes(bgColor: .white, placeholderTxt: "Enter Zip Code", placeholderColor: .lightGray, txtColor: .black)
        text.textAlignment = .center
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupCityLabelConstraints()
        setupCollectionViewConstraints()
        setupTextFieldConstraints()
    }
    
    private func setupCityLabelConstraints() {
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupTextFieldConstraints() {
        addSubview(zipTextField)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zipTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            zipTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            zipTextField.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5)
        ])
    }


}

extension UITextField {
    func setAttributes(bgColor: UIColor, placeholderTxt: String, placeholderColor: UIColor, txtColor: UIColor) {
        self.backgroundColor = bgColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderTxt, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        self.textColor = txtColor
    }
}
