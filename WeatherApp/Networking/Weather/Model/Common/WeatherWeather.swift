//
//  WeatherWeather.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

struct WeatherWeather: Codable {
    var id: Int
    var main: WeatherType
    var icon: String
    var description: String
}

