//
//  MapViewController.swift
//  BackBaseCitySearch
//
//  Created by Sasidhar Koti on 03/02/20.
//  Copyright © 2020 Sasidhar Koti. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var city: City? {
        didSet {
            title = city!.nameAndCountry
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let city = city else { return }

        mapView.region = MKCoordinateRegion(center: city.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
    
}
