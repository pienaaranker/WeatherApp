//
//  SearchManager.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/08.
//

import Foundation
import MapKit

class SearchManager {
    weak var delegate: SearchManagerDelegate?
    init(delegate: SearchManagerDelegate) {
        self.delegate = delegate
    }
    
    func searchLocales(text: String){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.resultTypes = .address
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            self.delegate?.searchManagerdidResponse(response: response, error: error)
        }
    }
}
