//
//  Utils.swift
//  Curiocity
//
//  Created by Amy Wong on 4/26/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import Foundation

class Utils {
    
    class func clientID() -> String {
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        let cid = NSDictionary(contentsOfFile: path!)?.valueForKey("client_id") as! String
        return cid
    }
    
    class func getCitySearchResults(city: String) -> NSURL {
        let cid = clientID()
        let urlStr = "http://terminal2.expedia.com/x/suggestions/regions?query=\(city)&apikey=\(cid)"
        return NSURL(string: urlStr)!
    }
    
}