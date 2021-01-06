//
//  WeatherManagerDelegate.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Alamofire

protocol WeatherManagerDelegate: class {
    func fetchCurrentWeatherResponded(with currentWeather: WeatherCurrentResponse?, error: AFError?)
    func fetchWeatherForecastResponded(with weatherForecast: WeatherForecastResponse?, error: AFError?)
}
