//
//  SearchManagerDelegate.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/08.
//

import Foundation
import MapKit

protocol SearchManagerDelegate: class {
    func searchManagerdidResponse(response: MKLocalSearch.Response?, error: Error?)
    
}
