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
    var lat: String
    var long: String
    
    /* Parses a NSDictionary and creates a photo object. */
//    init (name: String, lat: String, long: String) {
    init (dict: NSDictionary) {
        lat = dict.valueForKey("ll")!.valueForKey("lat") as! String
        long = dict.valueForKey("ll")!.valueForKey("lat") as! String
        name = dict.valueForKey("d") as! String
        name = self.parseCityName(name)
    }
    
    func parseCityName(name: String) ->String{
        var parsedStr = name
        if parsedStr.containsString("<B>") {
            parsedStr = parsedStr.stringByReplacingOccurrencesOfString("<B>", withString: "")
        }
        if parsedStr.containsString("</B>") {
            parsedStr = parsedStr.stringByReplacingOccurrencesOfString("</B>", withString: "")
        }
        return parsedStr
    }
}