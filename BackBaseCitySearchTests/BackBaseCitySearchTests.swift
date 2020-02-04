//
//  BackBaseCitySearchTests.swift
//  BackBaseCitySearchTests
//
//  Created by Sasidhar Koti on 03/02/20.
//  Copyright © 2020 Sasidhar Koti. All rights reserved.
//

import XCTest
@testable import BackBaseCitySearch

class BackBaseCitySearchTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testValidSearches() {
        
        let citySearchViewModel = CitySearchViewModel()
        let searches = ["amsterdam", "New york"]
        
        for search in searches {
            let result: (firstIndex: Int, lastIndex: Int) = citySearchViewModel.indexesOfSearch(search: search)
            
            let firstIndex = result.firstIndex
            let lastIndex = result.lastIndex
            
            let count = lastIndex - firstIndex
            if (count > 0) {
                for index in 0..<count {
                    let city = citySearchViewModel.modelAtIndex(indexPath: IndexPath(row: index, section: 0))
                    
                    if !city.name.lowercased().starts(with: search.lowercased()) {
                        XCTFail("The result \"\(city.name)\" does not match the search query \"\(search)\".")
                    }
                }
            } else {
                XCTFail("The result does not match the search query \"\(search)\".")
            }
            
        }
        XCTAssert(true, "Searches \(searches) found their respective results.")
    }
    
    func testInvalidSearches() {
        let citySearchViewModel = CitySearchViewModel()
        let searches = ["Aacd", "ebbb"]
        
        for search in searches {
            let result: (firstIndex: Int, lastIndex: Int) = citySearchViewModel.indexesOfSearch(search: search)
            
            let firstIndex = result.firstIndex
            let lastIndex = result.lastIndex
            let count = lastIndex - firstIndex
            if (count > 0) {
                 XCTFail("The result should be empty")
            } else {
                 XCTAssert(true, "Searches \(searches) are not found their respective results.")
            }
            
        }
    }
    
}
