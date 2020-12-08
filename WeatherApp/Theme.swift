//
//  Theme.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation
import UIKit

class Theme {
    
    var sunnyColor: UIColor
    var CloudyColor: UIColor
    var RainyColor: UIColor
    
    init(sunnyColor: UIColor, CloudyColor: UIColor, RainyColor: UIColor) {
        self.sunnyColor = sunnyColor
        self.CloudyColor = CloudyColor
        self.RainyColor = RainyColor
    }
}
