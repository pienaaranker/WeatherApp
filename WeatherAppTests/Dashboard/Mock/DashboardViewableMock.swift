//
//  DashboardViewableMock.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
@testable import WeatherApp

class DashboardViewableMock: DashboardViewable {
    
    var errorShown: String?
    var updatedWeather: WeatherCurrentResponse?
    var reloadTableViewCalled = false
    
    func showError(message: String) {
        errorShown = message
    }
    
    func updateCurrentWeather(currentWeather: WeatherCurrentResponse) {
        updatedWeather = currentWeather
    }
    
    func reloadTableView() {
        reloadTableViewCalled = true
    }
    
    func reset() {
        errorShown = nil
        updatedWeather = nil
        reloadTableViewCalled = false
    }
}
