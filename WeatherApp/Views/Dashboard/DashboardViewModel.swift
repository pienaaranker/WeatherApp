//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation
import Alamofire

class DashboardViewModel: WeatherManagerDelegate {
    
    private weak var viewable: DashboardViewable?
    
    var weatherManager: WeatherManager?    
    var currentWeather: WeatherCurrentResponse?
    var weatherForecast: WeatherForecastResponse?
    
    init(viewable: DashboardViewable) {
        self.viewable = viewable
        self.weatherManager = WeatherManager(delegate: self)
    }
    
    func fetchWeatherCurrent() {
        weatherManager?.fetchCurrentWeather(for: "Cape Town")
    }
    
    func fetchWeatherForecast() {
        weatherManager?.fetchWeatherForecast(for: "Cape Town")
    }
    
    func fetchCurrentWeatherResponded(with currentWeather: WeatherCurrentResponse?, error: AFError?) {
        if let error = error {
            self.viewable?.showError(message: error.errorDescription ?? "")
        } else if let currentWeather = currentWeather {
            self.currentWeather = currentWeather
            self.viewable?.updateCurrentWeather(currentWeather: currentWeather)
            self.viewable?.reloadTableView()
        }
    }
    
    func fetchWeatherForecastResponded(with weatherForecast: WeatherForecastResponse?, error: AFError?) {
        
            if let error = error {
                self.viewable?.showError(message: error.errorDescription ?? "")
            } else {
                self.weatherForecast = weatherForecast
                self.viewable?.reloadTableView()
            }
    }
    
    func getHeaderData() -> DashboardHeaderViewData? {
        guard let current = self.currentWeather else {
            return nil
        }
        
        return DashboardHeaderViewData(min: current.main.temp_min,
                                        current: current.main.temp,
                                        max: current.main.temp_max,
                                        color: AppConfig.shared.theme.sunnyColor)
    }
    
    func getNumberOfSections() -> Int {
        return currentWeather == nil ? 0 : 1
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        if let forecast = weatherForecast {
            return forecast.list.count
        } else {
            return 0
        }
    }

}
