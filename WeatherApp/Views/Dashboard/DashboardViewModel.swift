//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation
import Alamofire

class DashboardViewModel: WeatherManagerDelegate {
    
    
    weak var viewable: DashboardViewable?
    private var weatherManager: WeatherManager {
        return WeatherManager(delegate: self)

    }
        
    
    init(viewable: DashboardViewable) {
        self.viewable = viewable
    }
    
    func getWeatherCurrent() {
        weatherManager.getCurrentWeather(for: "Cape Town")
    }
    
    func getWeatherForecast() {
        weatherManager.getWeatherForecast(for: "Cape Town")
    }
    
    func getCurrentWeatherResponded(with currentWeather: WeatherCurrentResponse?, error: AFError?) {
        
    }
}
