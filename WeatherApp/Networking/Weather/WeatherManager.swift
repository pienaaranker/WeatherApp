//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import MapKit

class WeatherManager {
    
    var networkManager: NetworkManagable = NetworkManager()
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
    
    func fetchCurrentWeather(for cityName: String) {
        let request = WeatherRequest(q: cityName, units: "metric", appid: AppConfig.shared.weatherAPIKey)
        guard let parameters = request.toQueryDictionary(),
            let url = WeatherManager.endPoints.weatherCurrent(parameters: parameters) else {
            fatalError("Could not parse weather api to url")
        }
        
        networkManager.performRequest(url: url, method: .get) { response, error in
            if let data = response {
                do {
                    let currentWeather = try JSONDecoder().decode(WeatherCurrentResponse.self, from: data)
                    self.delegate?.fetchCurrentWeatherResponded(with: currentWeather, error: nil)
                    print(currentWeather.main)
                } catch (let error ) {
                    print("Could not parse json: \(error)")
                }
            } else if let error = error {
                self.delegate?.fetchCurrentWeatherResponded(with: nil, error: error)
                print(error)
            } else {
                print("parsing error")
            }
        }
    }
    
    func fetchWeatherForecast(for cityName: String) {
        let request = WeatherRequest(q: cityName, units: "metric", appid: AppConfig.shared.weatherAPIKey)
        guard let parameters = request.toQueryDictionary(),
              let url = WeatherManager.endPoints.weatherForcast(parameters: parameters) else {
            fatalError("Could not parse weather api to url")
        }
        
        networkManager.performRequest(url: url, method: .get) { response, error in
            if let data = response {
                do {
                    let forecast = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
                    self.delegate?.fetchWeatherForecastResponded(with: forecast, error: nil)
                } catch (let error ) {
                    print("Could not parse json: \(error)")
                }
            } else if let error = error {
                self.delegate?.fetchCurrentWeatherResponded(with: nil, error: error)
            }
        }
    }
}
