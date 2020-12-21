//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import MapKit

class WeatherManager {
    
    private let networkManager = NetworkManager()
    private let delegate: WeatherManagerDelegate?
    
    init(delegate: WeatherManagerDelegate?) {
        self.delegate = delegate
    }
    
    struct endPoints {
        private static let domain = "//api.openweathermap.org/data/2.5"
        
        static func weatherCurrent(parameters: [String: String]) -> URL? {
            return NetworkManager.url(from: "\(domain)/weather", queryParameters: parameters)
        }
        
        static func weatherForcast(parameters: [String: String]) -> URL? {
            return NetworkManager.url(from: "\(domain)/forecast", queryParameters: parameters)
        }
    }
    
    func getCurrentWeather(for cityName: String) {
        let request = WeatherCurrentRequest(q: cityName, appid: AppConfig.shared.weatherAPIKey)
        guard let parameters = request.toQueryDictionary(),
            let url = WeatherManager.endPoints.weatherCurrent(parameters: parameters) else {
            fatalError("Could not parse weather api to url")
        }
        
        networkManager.performRequest(url: url, method: .get)
    }
}
