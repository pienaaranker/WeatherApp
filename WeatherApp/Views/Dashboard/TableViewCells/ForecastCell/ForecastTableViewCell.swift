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
        
        backgroundColor = AppConfig.shared.theme.sunnyColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(dayName: String, typeImage: UIImage, temperature: Double) {
        dayLabel.text = dayName
        weatherTypeImageView.image = typeImage
        temperatureLabel.text = temperature.temperatureString()
    }
    
}
