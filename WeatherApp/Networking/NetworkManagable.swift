//
//  NetworkManagable.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Alamofire

protocol NetworkManagable {
    func performRequest(url: URL, method: HTTPMethod, completion: @escaping (Data?, AFError?) -> Void)
}
