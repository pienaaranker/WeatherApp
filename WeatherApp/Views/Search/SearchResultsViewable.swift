//
//  SearchResultsViewable.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/08.
//

import Foundation

protocol SearchResultsViewable: class {
    func reloadTableView()
    func showError(message: String)
}
