//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/06.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dayLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        dayLabel.textColor = AppConfig.shared.theme.primaryTextColor
        
        temperatureLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        temperatureLabel.textColor = AppConfig.shared.theme.primaryTextColor
        
        backgroundColor = .clear
        
    }
    
    func configure(dayName: String, typeImage: UIImage, temperature: Double) {        
        dayLabel.text = dayName
        weatherTypeImageView.image = typeImage
        temperatureLabel.text = temperature.temperatureString()
    }
    
}
