//
//  CitySearchViewController.swift
//  BackBaseCitySearch
//
//  Created by Sasidhar Koti on 03/02/20.
//  Copyright © 2020 Sasidhar Koti. All rights reserved.
//

import UIKit

// City search ViewController
class CitySearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //searchcontroller
    let searchController = UISearchController(searchResultsController: nil)
    
    //viewmodel for class
    let viewModel: CitySearchViewModel = CitySearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        setUpView()
    }
    
    //method to searchController
    private func setUpView() {
        definesPresentationContext = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        }
        else {
            tableView.tableHeaderView = searchController.searchBar
        }
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search cities"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //register push notifications
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(CitySearchViewController.keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CitySearchViewController.keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            guard let city = sender as? City else { return }
            guard let destinationViewController = segue.destination as? MapViewController else { return }
            destinationViewController.city = city
        }
    }
    
    // MARK: - Keyboard show/hide methods
    @objc func keyBoardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            tableView.contentInset = edgeInsets
            tableView.scrollIndicatorInsets = edgeInsets
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
}

// MARK: - UITableViewDataSource
extension CitySearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityInfoCell", for: indexPath)
        
        let city = viewModel.modelAtIndex(indexPath: indexPath)
        cell.textLabel?.text = city.nameAndCountry
        cell.detailTextLabel?.text = city.coord.description
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CitySearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.modelAtIndex(indexPath: indexPath)
        performSegue(withIdentifier: "MapSegue", sender: city)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating
extension CitySearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterSearch(search: searchController.searchBar.text!)
        tableView.reloadData()
    }
    
}


