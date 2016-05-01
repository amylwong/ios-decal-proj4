//
//  PointOfInterest.swift
//  Curiocity
//
//  Created by Amy Wong on 5/1/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import Foundation

class PointOfInterest {
    var POIName: String
    var lat: String
    var long: String
    
    init (name: String, lat: String, long: String) {
        self.POIName = name
        self.lat = lat
        self.long = long
    }
}
