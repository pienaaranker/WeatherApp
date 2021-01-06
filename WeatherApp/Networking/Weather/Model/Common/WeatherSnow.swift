//
//  WeatherSnow.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation

struct WeatherSnow: Codable {
    var last1h: Double?
    var last3h: Double?
    
    enum CodingKeys: String, CodingKey {
        case last1h = "1h"
        case last3h = "3h"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.last1h = try container.decodeIfPresent(Double.self, forKey: .last1h)
        self.last3h = try container.decodeIfPresent(Double.self, forKey: .last3h)
    }
}
