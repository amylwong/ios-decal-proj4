//
//  City.swift
//  Curiocity
//
//  Created by Amy Wong on 4/27/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import Foundation

class City {
    var name: String
    var lat: Int
    var long: Int
    
    
    /* Parses a NSDictionary and creates a photo object. */
    init (name: String, lat: Int, long: Int) {
//    init (data: NSDictionary) {
//         FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
//        self.name = data.valueForKey("sr")!.valueForKey("count") as! Int
//        self.url = data.valueForKey("images")!.valueForKey("standard_resolution")!.valueForKey("url") as! String
//        self.username = data.valueForKey("user")!.valueForKey("username") as! String
//        self.date = data.valueForKey("created_time") as! String
        print("City.swift")
        self.name = name
        self.lat = lat
        self.long = long
    }
}