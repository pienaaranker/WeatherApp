//
//  DashboardViewable.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/10.
//

import Foundation

protocol DashboardViewable: class {
    func showError(message: String)
    func updateCurrentWeather(currentWeather: WeatherCurrentResponse)
    func reloadTableView()
}
