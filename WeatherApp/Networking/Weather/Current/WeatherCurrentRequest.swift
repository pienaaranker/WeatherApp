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
    
    enum CodingKeys: CodingKey {
        case q
        case appid
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(q, forKey: .q)
        try container.encode(appid, forKey: .appid)
    }
    
}
