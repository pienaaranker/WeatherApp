//
//  DashboardViewModelsTests.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Quick
import Nimble
@testable import WeatherApp

class DashboardViewModelTests: QuickSpec {
    
    var viewModelUnderTest: DashboardViewModel?
    var mockNetworkManager = NetworkManagableMock()
    var mockViewable = DashboardViewableMock()
    
    override func spec() {
        
        beforeEach {
            self.viewModelUnderTest = DashboardViewModel(viewable: self.mockViewable)
            self.viewModelUnderTest?.weatherManager?.networkManager = self.mockNetworkManager
            self.resetMocks()
        }
        
        weatherManagerTests()
    }
    
    func resetMocks() {
        self.mockViewable.reset()
        self.mockNetworkManager.reset()
    }
    
    func weatherManagerTests() {
        describe("Given we are on the dashboard") {
            
            context("When get weather current call succeeds") {
                
                it("Then store the current weather response") {
                    self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateCurrentWeatherData()
                    self.viewModelUnderTest?.getWeatherCurrent()
                    
                    expect(self.viewModelUnderTest?.currentWeather?.name) == "Cape Town"
                }
            }
        }
    }
    
}
