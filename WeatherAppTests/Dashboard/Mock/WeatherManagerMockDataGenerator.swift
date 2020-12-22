//
//  WeatherManagerMockDataGenerator.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

class WeatherManagerMockDataGenerator {
    
    static func generateCurrentWeatherData() -> Data? {
        return try? JSONHelper.fetchJsonData(in: "WeatherCurrentResponse")
    }
    
}
