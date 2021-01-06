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
    
    func create(temperature: String, font: UIFont, textColor: UIColor) -> DegreesLabelView? {
        guard let view = Bundle.main.loadNibNamed(String(describing: DegreesLabelView.self), owner: nil, options: [:])?.first as? DegreesLabelView else {
            return nil
        }
        
        view.backgroundColor = .clear
        
        view.temperatureLabel.text = temperature
        view.temperatureLabel.font = font
        view.temperatureLabel.textColor = textColor
        
        view.degreeSymbolLabel.text = "°"
        view.degreeSymbolLabel.font = font
        view.degreeSymbolLabel.textColor = textColor
        
        return view
    }
    
    func setTemperature(temperature: String) {
        temperatureLabel.text = temperature
    }
    
}
