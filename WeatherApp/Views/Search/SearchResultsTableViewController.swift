//
//  SearchResultsTableViewController.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/08.
//

import UIKit

protocol SearchResultsTableViewControllerDelegate: class {
    func didSelect(result: String)
}

class SearchResultsTableViewController: UITableViewController, SearchResultsViewable {
        
    var viewModel: SearchResultsViewModel!
    
    init(delegate: SearchResultsTableViewControllerDelegate){
        super.init(nibName:String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        viewModel = SearchResultsViewModel(viewable: self, delegate: delegate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Viewable
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func showError(message: String) {
//        self.showAlert(title: GlobalStrings.Alert.errorTitle, message: message, handler: nil)
        print(message)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = viewModel.results[indexPath.row]
        cell.textLabel?.text = data.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(index: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchResultsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
           text.count > 2 {
            viewModel.search(text: text)
        }
    }
}
