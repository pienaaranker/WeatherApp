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
    
    func getWeatherCurrent() {
        weatherManager?.getCurrentWeather(for: "Cape Town")
    }
    
    func getWeatherForecast() {
        weatherManager?.getWeatherForecast(for: "Cape Town")
    }
    
    func getCurrentWeatherResponded(with currentWeather: WeatherCurrentResponse?, error: AFError?) {
        if let error = error {
            //TODO: Show api error through viewable
        } else {
            self.currentWeather = currentWeather
            //TODO: reload table with valid data
        }
    }
    
    func getWeatherForecastResponded(with weatherForecast: WeatherForecastResponse?, error: AFError?) {
        
            if let error = error {
                //TODO: Show api error through viewable
            } else {
                self.weatherForecast = weatherForecast
                //TODO: reload table with valid data
            }
    }
}
