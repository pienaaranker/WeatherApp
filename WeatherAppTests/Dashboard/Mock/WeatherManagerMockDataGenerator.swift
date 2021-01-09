//
//  WeatherManagerMockDataGenerator.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Alamofire

class WeatherManagerMockDataGenerator {
    
    static func generateCurrentWeatherData() -> Data? {
        return try? JSONHelper.fetchJsonData(in: "WeatherCurrentResponse")
    }
    
    static func generateForecastWeatherData() -> Data? {
        return try? JSONHelper.fetchJsonData(in: "WeatherForecastResponse")
    }
    
    static func generateError() -> AFError? {
        return AFError.explicitlyCancelled
    }
    
}
