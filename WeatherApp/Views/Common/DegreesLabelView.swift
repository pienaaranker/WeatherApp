//
//  DegreesLabelView.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/10.
//

import UIKit

class DegreesLabelView: UIView {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var degreeSymbolLabel: UILabel!
    
    func configure(temperature: String, font: UIFont, textColor: UIColor) {
        Bundle.main.loadNibNamed(String(describing: DegreesLabelView.self), owner: self, options: .none)
        self.backgroundColor = .clear
        
        temperatureLabel.text = temperature
        temperatureLabel.font = font
        temperatureLabel.textColor = textColor
        
        degreeSymbolLabel.text = "°"
        degreeSymbolLabel.font = font
        degreeSymbolLabel.textColor = textColor
    }
    
}
