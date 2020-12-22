//
//  WeatherManagerDelegate.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Alamofire

protocol WeatherManagerDelegate: class {
    func getCurrentWeatherResponded(with currentWeather: WeatherCurrentResponse?, error: AFError?)
    func getWeatherForecastResponded(with weatherForecast: WeatherForecastResponse?, error: AFError?)
}
