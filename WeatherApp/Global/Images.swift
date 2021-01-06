//
//  Images.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation
import UIKit

struct Images {
    
    struct Cloudy {
        static let forest = UIImage(named: "forest_cloudy")!
        static let sea = UIImage(named: "sea_cloudy")!
    }
    
    struct Rainy {
        static let forest = UIImage(named: "forest_rainy")!
        static let sea = UIImage(named: "sea_rainy")!
        
    }
    
    struct Sunny {
        static let forest = UIImage(named: "forest_sunny")!
        static let sea = UIImage(named: "sea_sunny")!
    }
    
    struct WeatherTypes {
        static let clear = UIImage(named: "clear")!
        static let partlySunny = UIImage(named: "partlysunny")!
        static let rain = UIImage(named: "rain")!
        
    }
}
