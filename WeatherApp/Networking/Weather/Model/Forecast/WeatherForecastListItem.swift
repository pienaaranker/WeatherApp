//
//  WeatherForecastListItem.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
struct WeatherForecastListItem: Codable {
    var dt: Int
    var main: WeatherMain
    var weather: [WeatherWeather]?
    var clouds: WeatherClouds?
    var wind: WeatherWind?
    var visibility: Int
    var pop: Double
    var rain: WeatherRain?
    var sys: WeatherSystem
    var dt_txt: String
}
