//
//  CitySearchViewModel.swift
//  BackBaseCitySearch
//
//  Created by Sasidhar Koti on 04/02/20.
//  Copyright © 2020 Sasidhar Koti. All rights reserved.
//

import Foundation


//view modlel class for citySearchViewcontroller
class CitySearchViewModel {
    let filterUtil: FilterUtil
    
    init() {
        filterUtil = FilterUtil()
    }
    
    //method to return number of rows
    func numberOfRows() -> Int {
        return filterUtil.resultsCount
    }
    
    //method to return model at indexPath
    func modelAtIndex(indexPath: IndexPath) -> City {
        return filterUtil.itemWithOffset(offset: indexPath.row)
    }
    
    //method to filter Content
    func filterSearch(search: String) {
        filterUtil.filter(search: search)
    }
    
    func indexesOfSearch(search: String) -> (firstIndex: Int, lastIndex: Int) {
         filterUtil.filter(search: search)
         return (filterUtil.resultsIndex.first, filterUtil.resultsIndex.last)
    }
}
