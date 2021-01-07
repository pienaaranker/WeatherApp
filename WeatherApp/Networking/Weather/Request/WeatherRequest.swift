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
    var cnt: String?
    var appid: String
    
    init(q: String, units: String?, cnt: Int?, appid: String) {
        self.q = q
        self.units = units
        self.appid = appid
        if let cnt = cnt {
            self.cnt = "\(cnt)"
        }
    }
    
    enum CodingKeys: CodingKey {
        case q
        case units
        case cnt
        case appid
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(q, forKey: .q)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(cnt, forKey: .cnt)
        try container.encode(appid, forKey: .appid)
    }
    
}
