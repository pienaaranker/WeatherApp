//
//  WeatherForecastResponse.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

struct WeatherForecastResponse: Codable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [WeatherForecastListItem]
    var city: WeatherCity
}
