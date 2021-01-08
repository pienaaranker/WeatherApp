//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/10.
//

import UIKit
import MapKit

class DashboardViewController: UIViewController, DashboardViewable {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DashboardViewModel!
    let locationManager = CLLocationManager()
    
    init(){
        super.init(nibName:String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
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
        configureLocationManager()
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
        
        locationLabel.font = AppConfig.shared.theme.primaryFont.withSize(24)
        locationLabel.textColor = AppConfig.shared.theme.primaryTextColor
        locationLabel.textAlignment = .center
        locationLabel.text = "Current location"
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = AppConfig.shared.theme.sunnyColor
        self.tableView.sectionFooterHeight = 0.5
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedSectionHeaderHeight = 80
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        
        let nib = UINib(nibName: String(describing: ForecastTableViewCell.self), bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: ForecastTableViewCell.self))
    }
    
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func tappedSearch(_ sender: Any) {
        let resultsController = SearchResultsTableViewController(delegate: self)
        let searchVC = UISearchController(searchResultsController: resultsController)
        searchVC.searchResultsUpdater = resultsController
        searchVC.searchBar.placeholder = "Search"
        present(searchVC, animated: true, completion: nil)
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
        
        if let lastLocation = viewModel.lastSearchedLocation {
            locationLabel.text = lastLocation
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForecastTableViewCell.self)) as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        
        let weatherItem = viewModel.filteredForecastList[indexPath.row]
        let dayName = viewModel.dateName(for: weatherItem)
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

extension DashboardViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            viewModel.fetchWeatherCurrent(coordinates: location)
            viewModel.fetchWeatherForecast(coordinates: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

extension DashboardViewController: SearchResultsTableViewControllerDelegate {
    func didSelect(result: String) {
        viewModel.fetchWeatherCurrent(cityName: result)
        viewModel.fetchWeatherForecast(cityName: result)
    }
}
