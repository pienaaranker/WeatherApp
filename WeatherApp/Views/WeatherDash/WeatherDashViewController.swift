//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import UIKit

class WeatherDashViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var degreeSymbolLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImage()
        configureLabels()
    }
    
    func configureImage() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Images.Sunny.forest
    }
    
    func configureLabels() {
        degreesLabel.font = AppConfig.shared.theme.primaryFont.withSize(68)
        degreesLabel.textColor = AppConfig.shared.theme.primaryTextColor
        degreesLabel.textAlignment = .center
        degreesLabel.text = "25"
        
        degreeSymbolLabel.font = AppConfig.shared.theme.primaryFont.withSize(68)
        degreeSymbolLabel.textColor = AppConfig.shared.theme.primaryTextColor
        degreeSymbolLabel.text = "°"
        
        weatherTypeLabel.font = AppConfig.shared.theme.primaryFont.withSize(36)
        weatherTypeLabel.textColor = AppConfig.shared.theme.primaryTextColor
        weatherTypeLabel.textAlignment = .center
        weatherTypeLabel.text = "SUNNY"
    }
    
    
}

// MARK: - TableView Delegate & Data Source
extension WeatherDashViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

