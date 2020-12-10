//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2020/12/08.
//

import Foundation

class DashboardViewModel {
    
    weak var viewable: DashboardViewable?
    
    init(viewable: DashboardViewable) {
        self.viewable = viewable
    }
}
