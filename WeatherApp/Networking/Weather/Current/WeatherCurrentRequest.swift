//
//  WeatherCurrentRequest.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

class WeatherCurrentRequest: APIRequest{
    var q: String
    var appid: String
    
    init(q: String, appid: String) {
        self.q = q
        self.appid = appid
    }
    
    
    
}
