//
//  DashboardHeaderView.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/10.
//

import UIKit

class DashboardHeaderView: UIView {
    @IBOutlet weak var minTempAmountLabel: UILabel!
    @IBOutlet weak var minTempDisplayLabel: UILabel!
    @IBOutlet weak var currentTempAmountLabel: UILabel!
    @IBOutlet weak var currentTempDisplayLabel: UILabel!
    @IBOutlet weak var maxTempAmountLabel: UILabel!
    @IBOutlet weak var maxTempDisplayLabel: UILabel!
    
    static func create(data: DashboardHeaderViewData) -> DashboardHeaderView? {
        guard let view = Bundle.main.loadNibNamed(String(describing: DashboardHeaderView.self), owner: nil, options: [:])?.first as? DashboardHeaderView else {
            return nil
        }
        view.configureLabels()
        view.minTempAmountLabel.text = data.min.temperatureString()
        view.currentTempAmountLabel.text = data.current.temperatureString()
        view.maxTempAmountLabel.text = data.max.temperatureString()
        view.backgroundColor = data.color
        
        return view
    }
    
    func configureLabels() {
        minTempAmountLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        minTempAmountLabel.textColor = AppConfig.shared.theme.primaryTextColor
        
        minTempDisplayLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        minTempDisplayLabel.textColor = AppConfig.shared.theme.primaryTextColor
        minTempDisplayLabel.text = "Min"
        
        currentTempAmountLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        currentTempAmountLabel.textColor = AppConfig.shared.theme.primaryTextColor
        
        currentTempDisplayLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        currentTempDisplayLabel.textColor = AppConfig.shared.theme.primaryTextColor
        currentTempDisplayLabel.text = "Current"
        
        maxTempAmountLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        maxTempAmountLabel.textColor = AppConfig.shared.theme.primaryTextColor
        
        maxTempDisplayLabel.font = AppConfig.shared.theme.primaryFont.withSize(14)
        maxTempDisplayLabel.textColor = AppConfig.shared.theme.primaryTextColor
        maxTempDisplayLabel.text = "Max"
        
    }
    
}
