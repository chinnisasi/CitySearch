//
//  FilterUtil.swift
//  BackBaseCitySearch
//
//  Created by Sasidhar Koti on 03/02/20.
//  Copyright © 2020 Sasidhar Koti. All rights reserved.
//

import Foundation

///class to filter cities based on user search
class FilterUtil: NSObject {
    
    // Array containing all city model elements
    var items = [City]()
    
    // Indexes for first and last item to show on list, filtered or not
    var resultsIndex: (first: Int, last: Int) = (first: 0, last: 0)
    
    //numberOfRows
    var resultsCount: Int {
        get {
            return resultsIndex.last - resultsIndex.first
        }
    }
    
    //city model at offset
    func itemWithOffset(offset: Int) -> City {
        return items[resultsIndex.first + offset]
    }
    
    override init() {
        super.init()
        loadData()
    }
    
    //load citises.json file
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            items = try JSONDecoder().decode([City].self, from: data)
            parseSearchValues()
            sortItems()
            resultsIndex = (first: 0, last: items.count - 1)
        }
        catch {
            print("Could not load JSON file.")
        }
    }
    
    //Set the search criteria, in lowercase
    private func parseSearchValues() {
        for index in 0..<items.count {
            items[index].searchValue = items[index].nameAndCountry.lowercased()
        }
    }
    
    //sort the itmes based on searchvalue
    private func sortItems() {
        items = items.sorted {
            $0.searchValue < $1.searchValue
        }
    }
    
    //filter method used to search
    func filter(search: String) {
        if search.isEmpty {
            // If search is empty, all items are visible
            resultsIndex = (first: 0, last: items.count - 1)
        }
        else {
            findRange(search: search)
        }
    }
    
    //method to find the first and last index
    private func findRange(search: String) {
        let indexFirst = findFirstIndex(search: search.lowercased())
        let indexLast = findLastIndex(search: search.lowercased())
        resultsIndex = (first: indexFirst, last: indexLast)
    }
    
    //method to find the first prefix
    private func findFirstIndex(search: String) -> Int {
        var low = 0
        var high = items.count - 1
        var mid = (low + high) / 2
        
        while low != mid {
            if search <= items[mid].searchValue {
                high = mid
            }
            else {
                low = mid
            }
            mid = (low + high) / 2
        }
        return high
    }
    
    //method to find the last prefix
    private func findLastIndex(search: String) -> Int {
        var low = 0
        var high = items.count - 1
        var mid = (low + high) / 2
        
        while low != mid {
            if items[mid].searchValue.starts(with: search) {
                low = mid
            }
            else {
                if search < items[mid].searchValue {
                    high = mid
                }
                else {
                    low = mid
                }
            }
            
            mid = (low + high) / 2
        }
        return high
    }
}
