//
//  WeatherCurrentResponse.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

struct WeatherCurrentResponse: Codable {
    var coord: WeatherCoordinate
    var timezone: Int
    var base: String
    var sys: WeatherSystem
    var clouds: WeatherClouds?
    var rain: WeatherRain?
    var snow: WeatherSnow?
    var id: Int
    var cod: Int
    var wind: WeatherWind?
    var weather: [WeatherWeather]?
    var main: WeatherMain
    var dt: Int
    var name: String
    var visibility: Int
}
