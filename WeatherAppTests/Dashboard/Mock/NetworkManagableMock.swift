//
//  NetworkManagableMock.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Alamofire
@testable import WeatherApp

class NetworkManagableMock: NetworkManagable {
    
    var dataOnCompletion: Data?
    var errorOnCompletion: AFError?
    
    func performRequest(url: URL, method: HTTPMethod, completion: @escaping (Data?, AFError?) -> Void) {
        if let data = dataOnCompletion {
            completion(data, nil)
        }
        
        if let error =  errorOnCompletion {
            completion(nil, error)
        }
    }
    
    func reset() {
        dataOnCompletion = nil
        errorOnCompletion = nil
    }
}
