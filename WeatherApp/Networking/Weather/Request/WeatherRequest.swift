//
//  WeatherCurrentRequest.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

class WeatherRequest: APIRequest{
    var q: String?
    var lat: String?
    var lon: String?
    var units: String?
    var cnt: String?
    var appid: String
    
    init(q: String? = nil, lat: String? = nil, lon: String? = nil, units: String? = nil, cnt: Int? = nil, appid: String) {
        self.q = q
        self.lat = lat
        self.lon = lon
        self.units = units
        self.appid = appid
        if let cnt = cnt {
            self.cnt = "\(cnt)"
        }
    }
    
    enum CodingKeys: CodingKey {
        case q
        case units
        case lat
        case lon
        case cnt
        case appid
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(q, forKey: .q)
        try container.encodeIfPresent(lat, forKey: .lat)
        try container.encodeIfPresent(lon, forKey: .lon)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(cnt, forKey: .cnt)
        try container.encode(appid, forKey: .appid)
    }
    
}
