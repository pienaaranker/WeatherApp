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
    
    private var theme: Theme
    
    init() {
        self.theme = Theme(sunnyColor: UIColor(hex: "#47AB2F")!,
                           CloudyColor: UIColor(hex: "#54717A")!,
                           RainyColor: UIColor(hex: "#57575D")!)
    }
}
