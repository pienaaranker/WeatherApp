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
    
    private var weatherManager: WeatherManager?    
    private var currentWeather: WeatherCurrentResponse?
    private var weatherForecast: WeatherForecastResponse?
    var filteredForecastList: [WeatherForecastListItem] = []
    private let dateFormatter = DateFormatter()
    
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
                filter5dayForecast(response: weatherForecast)
                self.viewable?.reloadTableView()
            }
    }
    
    func filter5dayForecast(response: WeatherForecastResponse?) {
        var list: [WeatherForecastListItem] = []
        let daysOfTheWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        dateFormatter.dateFormat = "EEEE"
        
        daysOfTheWeek.forEach { (day) in
            if let elementWithMaxTemp = response?.list
                .enumerated()
                .filter({ i, item in
                    let date = Date(timeIntervalSince1970: Double(item.dt))
                    return dateFormatter.string(from: date) == day
                })
                .max(by: { (prev, next) -> Bool in
                    prev.element.main.temp_max < next.element.main.temp_max
                }) {
                
                list.append(elementWithMaxTemp.element)
            }
        }
        
        self.filteredForecastList = list.sorted(by: { (item, next) -> Bool in
            return item.dt < next.dt
        })
    }
    
    func getHeaderData() -> DashboardHeaderViewData? {
        guard let current = self.currentWeather,
              let type = current.weather?.first?.main else {
            return nil
        }
        
        return DashboardHeaderViewData(min: current.main.temp_min,
                                        current: current.main.temp,
                                        max: current.main.temp_max,
                                        color: backgroundColor(for: type))
    }
    
    func getNumberOfSections() -> Int {
        return currentWeather == nil ? 0 : 1
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return filteredForecastList.count
    }
    
    func listImage(for weatherType: WeatherType) -> UIImage {
        switch weatherType {
        case .clear:
            return Images.WeatherTypes.clear
        case .clouds:
            return Images.WeatherTypes.partlySunny
        case .rain:
            return Images.WeatherTypes.rain
        default:
            return Images.WeatherTypes.rain
        }
    }
    
    func backgroundImage(for weatherType: WeatherType) -> UIImage {
        switch weatherType {
        case .clear:
            return Images.Sunny.forest
        case .clouds:
            return Images.Cloudy.forest
        case .rain:
            return Images.Rainy.forest
        default:
            return Images.Rainy.forest
        }
    }
    
    func backgroundColor(for weatherType: WeatherType) -> UIColor {
        switch weatherType {
        case .clear:
            return AppConfig.shared.theme.sunnyColor
        case .clouds:
            return AppConfig.shared.theme.rainyColor
        case .rain:
            return AppConfig.shared.theme.rainyColor
        default:
            return AppConfig.shared.theme.rainyColor
        }
    }
    
    func dateName(for forecastItem: WeatherForecastListItem) -> String {
        let date = Date(timeIntervalSince1970: Double(forecastItem.dt))
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

}
