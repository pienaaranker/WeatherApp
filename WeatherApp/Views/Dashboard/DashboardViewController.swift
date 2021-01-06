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
        configureTableView()
        viewModel.fetchWeatherCurrent()
        viewModel.fetchWeatherForecast()        
    }
    
    func configureView() {
        view.backgroundColor = AppConfig.shared.theme.sunnyColor
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
        weatherTypeLabel.text = "Loading..."
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = AppConfig.shared.theme.sunnyColor
        self.tableView.sectionFooterHeight = 0.5
        self.tableView.estimatedSectionHeaderHeight = 80
    }
    
    // MARK: - Viewable
    func showError(message: String) {
        self.showAlert(title: GlobalStrings.Alert.errorTitle, message: message, handler: nil)
    }
    
    func updateCurrentWeather(currentWeather: WeatherCurrentResponse) {
//        degreesView.setTemperature(temperature: "\(currentWeather.main.feels_like)")
        weatherTypeLabel.text = currentWeather.weather?.first?.description.uppercased()
    }
    
    func reloadTableView() {        
        self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = viewModel.getHeaderData() else {
            return nil
        }
        return DashboardHeaderView.create(data: data)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeaderData() == nil ? 0 : UITableView.automaticDimension
    }
}

