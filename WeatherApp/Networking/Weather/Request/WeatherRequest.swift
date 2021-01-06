//
//  WeatherCurrentRequest.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

class WeatherRequest: APIRequest{
    var q: String
    var units: String?
    var appid: String
    
    init(q: String, units: String?, appid: String) {
        self.q = q
        self.units = units
        self.appid = appid
    }
    
    enum CodingKeys: CodingKey {
        case q
        case units
        case appid
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(q, forKey: .q)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encode(appid, forKey: .appid)
    }
    
}
