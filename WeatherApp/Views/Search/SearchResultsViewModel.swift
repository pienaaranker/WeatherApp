//
//  SearchResultsViewModel.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/08.
//

import Foundation
import MapKit

class SearchResultsViewModel: SearchManagerDelegate {
    
    weak var delegate: SearchResultsTableViewControllerDelegate?
    weak var viewable: SearchResultsViewable?
    var searchManager: SearchManager!
    var results: [MKMapItem] = []
    
    init(viewable: SearchResultsViewable, delegate: SearchResultsTableViewControllerDelegate) {
        self.delegate = delegate
        self.viewable = viewable
        self.searchManager = SearchManager(delegate: self)
    }
    
    func search(text: String) {
        searchManager.searchLocales(text: text)
    }
    
    func searchManagerdidResponse(response: MKLocalSearch.Response?, error: Error?) {
        if let error = error {
            self.viewable?.showError(message: error.localizedDescription)
        } else {
            self.results = response?.mapItems ?? []
            self.viewable?.reloadTableView()    
        }
    }
    
    func didSelectRow(index: Int) {
        delegate?.didSelect(result: results[index].name ?? "")
    }
}
