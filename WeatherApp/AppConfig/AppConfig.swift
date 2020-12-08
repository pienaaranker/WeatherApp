//
//  AppConfig.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation
import UIKit

class AppConfig {
    
    static let shared = AppConfig()
    
    var theme: Theme
    
    init() {
        self.theme = Theme(primaryFont: UIFont(name: "Futura", size: 14)!,
                           primaryTextColor: .white,
                           sunnyColor: UIColor(hex: "#47AB2F")!,
                           cloudyColor: UIColor(hex: "#54717A")!,
                           rainyColor: UIColor(hex: "#57575D")!)
    }
}
