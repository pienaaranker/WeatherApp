//
//  Theme.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation
import UIKit

class Theme {
    
    var primaryFont: UIFont
    var primaryTextColor: UIColor
    var sunnyColor: UIColor
    var cloudyColor: UIColor
    var rainyColor: UIColor
    
    init(primaryFont: UIFont,
         primaryTextColor: UIColor,
         sunnyColor: UIColor,
         cloudyColor: UIColor,
         rainyColor: UIColor) {
        
        self.primaryFont = primaryFont
        self.primaryTextColor = primaryTextColor
        self.sunnyColor = sunnyColor
        self.cloudyColor = cloudyColor
        self.rainyColor = rainyColor
    }
}
