//
//  City.swift
//  Curiocity
//
//  Created by Amy Wong on 4/27/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import Foundation

class City {
    var name: NSMutableAttributedString
    var lat: Int
    var long: Int
    
    /* Parses a NSDictionary and creates a photo object. */
    init (name: NSMutableAttributedString, lat: Int, long: Int) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}