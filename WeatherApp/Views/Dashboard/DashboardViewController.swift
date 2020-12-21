//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/10.
//

import UIKit

class DashboardViewController: UIViewController, DashboardViewable {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var degreesView: DegreesLabelView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DashboardViewModel!
    
    init(){
        super.init(nibName:String(describing: type(of: self)), bundle: Bundle(for: DashboardViewController.self))
        viewModel = DashboardViewModel(viewable: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImage()
        configureLabels()
        viewModel.getWeatherCurrent()
    }
    
    func configureImage() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Images.Sunny.forest
    }
    
    func configureLabels() {
        degreesView.configure(temperature: "25",
                              font: AppConfig.shared.theme.primaryFont.withSize(68),
                              textColor: AppConfig.shared.theme.primaryTextColor)
        
        weatherTypeLabel.font = AppConfig.shared.theme.primaryFont.withSize(36)
        weatherTypeLabel.textColor = AppConfig.shared.theme.primaryTextColor
        weatherTypeLabel.textAlignment = .center
        weatherTypeLabel.text = "SUNNY"
    }
}

// MARK: - TableView Delegate & Data Source
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
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

