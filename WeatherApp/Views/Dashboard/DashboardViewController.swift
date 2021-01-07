//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/10.
//

import UIKit

class DashboardViewController: UIViewController, DashboardViewable {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
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
        
        configureView()
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
        temperatureLabel.font = AppConfig.shared.theme.primaryFont.withSize(64)
        temperatureLabel.textColor = AppConfig.shared.theme.primaryTextColor
        temperatureLabel.textAlignment = .center
        temperatureLabel.text = ""
        
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
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedSectionHeaderHeight = 80
        self.tableView.separatorStyle = .none
        
        let nib = UINib(nibName: String(describing: ForecastTableViewCell.self), bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: ForecastTableViewCell.self))
    }
    
    // MARK: - Viewable
    func showError(message: String) {
        self.showAlert(title: GlobalStrings.Alert.errorTitle, message: message, handler: nil)
    }
    
    func updateCurrentWeather(currentWeather: WeatherCurrentResponse) {
        temperatureLabel.text = currentWeather.main.temp.temperatureString()
        weatherTypeLabel.text = currentWeather.weather?.first?.description.uppercased()
        if let type = currentWeather.weather?.first?.main {
            backgroundImageView.image = viewModel.backgroundImage(for: type)
            view.backgroundColor = viewModel.backgroundColor(for: type)
            tableView.backgroundColor = viewModel.backgroundColor(for: type)
        }
    }
    
    func reloadTableView() {        
        self.tableView.reloadData()
    }
}

// MARK: - TableView Delegate & Data Source
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForecastTableViewCell.self)) as? ForecastTableViewCell,
              let data = viewModel.weatherForecast else {
            return UITableViewCell()
        }
        
        let weatherItem = data.list[indexPath.row]
        let dayName = weatherItem.dt_txt
        let image = viewModel.listImage(for: weatherItem.weather?.first?.main ?? .clear)
        let temp = weatherItem.main.temp
        
        
        cell.configure(dayName: dayName, typeImage: image, temperature: temp)
        
        return cell
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

