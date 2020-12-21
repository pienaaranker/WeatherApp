//
//  WeatherCity.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

struct WeatherCity: Codable {
    var id: Int
    var name: String
    var coord: WeatherCoordinate
    var country: String
    var timezone: Int
    var sunrise: Int
    var sunset: Int
}
