//
//  weatherSystem.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

struct WeatherSystem: Codable {
    var id: Int
    var country: String
    var sunset: Int
    var type: Int
    var sunrise: Int
}
