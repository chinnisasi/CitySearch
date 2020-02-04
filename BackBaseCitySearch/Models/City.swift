//
//  City.swift
//  BackBaseCitySearch
//
//  Created by Sasidhar Koti on 03/02/20.
//  Copyright © 2020 Sasidhar Koti. All rights reserved.
//

import Foundation
import MapKit

/// Model to represent coordinates
struct CoordinatesInfo: Decodable {
    
    let lon: Double
    let lat: Double
    
    var description: String {
        return "\(lat), \(lon)"
    }
    
}


/// Model to represent each city
struct City: Decodable {

    private enum CodingKeys: String, CodingKey { case country, name, coord }

    let country: String
    let name: String
    let coord: CoordinatesInfo

    ///searchValue (lower case) is used while  filtering results
    var searchValue = ""
    
    var nameAndCountry: String {
        get {
            return "\(name), \(country)"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(coord.lat, coord.lon)
        }
    }

}

