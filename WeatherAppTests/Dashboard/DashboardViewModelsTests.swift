//
//  DashboardViewModelsTests.swift
//  WeatherAppTests
//
//  Created by Pienaar Anker on 2020/12/21.
//

import Foundation
import Quick
import Nimble
import Alamofire
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
        generalTests()
    }
    
    func resetMocks() {
        self.mockViewable.reset()
        self.mockNetworkManager.reset()
    }
    
    func weatherManagerTests() {
        describe("Given we are on the dashboard") {
            
            context("When fetch weather current call") {
                
                context("succeeds") {
                    
                    it("Then store the current weather response") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateCurrentWeatherData()
                        self.viewModelUnderTest?.fetchWeatherCurrent(cityName: "Cape Town")
                        
                        expect(self.viewModelUnderTest?.currentWeather?.name) == "Cape Town"
                    }
                    
                    it("Then update viewable") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateCurrentWeatherData()
                        self.viewModelUnderTest?.fetchWeatherCurrent(cityName: "Cape Town")
                        
                        expect(self.mockViewable.updatedWeather?.name) == "Cape Town"
                    }
                    
                    it("Then reload tableview") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateCurrentWeatherData()
                        self.viewModelUnderTest?.fetchWeatherCurrent(cityName: "Cape Town")
                        
                        expect(self.mockViewable.reloadTableViewCalled) == true
                    }
                }
                
                context("fails") {
                        
                        it("Then show error") {
                            self.mockNetworkManager.errorOnCompletion = WeatherManagerMockDataGenerator.generateError()
                            self.viewModelUnderTest?.fetchWeatherCurrent(cityName: "Cape Town")
                            
                            expect(self.mockViewable.errorShown) == "Request explicitly cancelled."
                        }
                }
            }
            
            context("When fetch weather forecast call") {
                context("succeeds") {
                    
                    it("Then filter list to one entry per day") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateForecastWeatherData()
                        self.viewModelUnderTest?.fetchWeatherForecast(cityName: "Cape Town")
                        
                        expect(self.viewModelUnderTest?.filteredForecastList.count) == 6
                        expect(self.viewModelUnderTest?.filteredForecastList.first?.main.temp_max) == 297.32
                    }
                    
                    it("Then reload tableview") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateForecastWeatherData()
                        self.viewModelUnderTest?.fetchWeatherForecast(cityName: "Cape Town")
                        
                        expect(self.mockViewable.reloadTableViewCalled) == true
                    }
                }
                
                context("fails") {
                        
                        it("Then show error") {
                            self.mockNetworkManager.errorOnCompletion = WeatherManagerMockDataGenerator.generateError()
                            self.viewModelUnderTest?.fetchWeatherForecast(cityName: "Cape Town")
                            
                            expect(self.mockViewable.errorShown) == "Request explicitly cancelled."
                        }
                }
            }
        }
    }
    
    func generalTests() {
        describe("Given we are on the dashboard") {
            
            context("When get header data is called") {
                
                context("and current weather has not been updated") {
                    
                    it("Then return nil") {
                        expect(self.viewModelUnderTest?.getHeaderData()).to(beNil())
                    }
                }
                
                context("and current weather has been updated") {
                    
                    it("Then return header data") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateCurrentWeatherData()
                        self.viewModelUnderTest?.fetchWeatherCurrent(cityName: "Cape Town")
                        
                        expect(self.viewModelUnderTest?.getHeaderData()?.min) == 295.93
                        expect(self.viewModelUnderTest?.getHeaderData()?.current) == 298.99
                        expect(self.viewModelUnderTest?.getHeaderData()?.max) == 301.15
                    }
                }
            }
            
            context("When get number of sections is called") {
                
                context("and current weather has not been updated") {
                    
                    it("Then return 0") {
                        expect(self.viewModelUnderTest?.getNumberOfSections()) == 0
                    }
                }
                
                context("and current weather has been updated") {
                    
                    it("Then return 1") {
                        self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateCurrentWeatherData()
                        self.viewModelUnderTest?.fetchWeatherCurrent(cityName: "Cape Town")
                        
                        expect(self.viewModelUnderTest?.getNumberOfSections()) == 1
                    }
                }
            }
            
            context("When get number of rows is called") {
                
                it("Then return filtered list count") {
                    self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateForecastWeatherData()
                    self.viewModelUnderTest?.fetchWeatherForecast(cityName: "Cape Town")
                    
                    expect(self.viewModelUnderTest?.getNumberOfRowsInSection(section: 0)) == 6
                }
            }
            
            context("When listImage is called") {
                
                context("for type clear") {
                    
                    it("Then return clear image") {
                        expect(self.viewModelUnderTest?.listImage(for: .clear).pngData()) == Images.WeatherTypes.clear.pngData()
                    }
                }
                
                context("for type clouds") {
                    
                    it("Then return clouds image") {
                        expect(self.viewModelUnderTest?.listImage(for: .clouds).pngData()) == Images.WeatherTypes.partlySunny.pngData()
                        
                    }
                }
                
                context("for type rain") {
                    
                    it("Then return rain image") {
                        expect(self.viewModelUnderTest?.listImage(for: .rain).pngData()) == Images.WeatherTypes.rain.pngData()
                        
                    }
                }
                
                context("for default type") {
                    
                    it("Then return rain image") {
                        expect(self.viewModelUnderTest?.listImage(for: .drizzle).pngData()) == Images.WeatherTypes.rain.pngData()
                        
                    }
                }
            }
            
            context("When backgroundImage is called") {
                
                context("for type clear") {
                    
                    it("Then return sunny image") {
                        expect(self.viewModelUnderTest?.backgroundImage(for: .clear).pngData()) == Images.Sunny.forest.pngData()
                    }
                }
                
                context("for type clouds") {
                    
                    it("Then return cloudy image") {
                        expect(self.viewModelUnderTest?.backgroundImage(for: .clouds).pngData()) == Images.Cloudy.forest.pngData()
                    }
                }
                
                context("for type rain") {
                    
                    it("Then return rainy image") {
                        expect(self.viewModelUnderTest?.backgroundImage(for: .rain).pngData()) == Images.Rainy.forest.pngData()
                    }
                }
                
                context("for default type") {
                    
                    it("Then return rainy image") {
                        expect(self.viewModelUnderTest?.backgroundImage(for: .drizzle).pngData()) == Images.Rainy.forest.pngData()
                    }
                }
            }
            
            context("When backgroundColor is called") {
                
                context("for type clear") {
                    
                    it("Then return sunny colour") {
                        expect(self.viewModelUnderTest?.backgroundColor(for: .clear)) == AppConfig.shared.theme.sunnyColor
                        
                    }
                }
                
                context("for type clouds") {
                    
                    it("Then return rainy colour") {
                        expect(self.viewModelUnderTest?.backgroundColor(for: .clouds)) == AppConfig.shared.theme.rainyColor
                        
                    }
                }
                
                context("for type rain") {
                    
                    it("Then return rainy colour") {
                        expect(self.viewModelUnderTest?.backgroundColor(for: .rain)) == AppConfig.shared.theme.rainyColor
                        
                    }
                    
                }
                
                context("for default type") {
                    
                    it("Then return rainy colour") {
                        expect(self.viewModelUnderTest?.backgroundColor(for: .drizzle)) == AppConfig.shared.theme.rainyColor
                    }
                }
            }
            
            context("When dateName for forecastitem is called") {
                
                it("Then return name of day for forecast item date") {
                    self.mockNetworkManager.dataOnCompletion = WeatherManagerMockDataGenerator.generateForecastWeatherData()
                    self.viewModelUnderTest?.fetchWeatherForecast(cityName: "Cape Town")
                    let item = self.viewModelUnderTest!.filteredForecastList.first!
                    
                    expect(self.viewModelUnderTest?.dateName(for: item)) == "Monday"
                }
            }
        }
    }
}
