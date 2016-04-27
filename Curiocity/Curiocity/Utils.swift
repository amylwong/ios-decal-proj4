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
    
//    class func getCitySearchResults() -> NSURL {
//        let cid = clientID()
//        let urlStr = "http://terminal2.expedia.com/x/suggestions/regions?query=las%20vegas&apikey=\(cid)"
//        return NSURL(string: urlStr)!
//    }
    
    class func getCitySearchResults(city: String) -> NSURL {
        print(city)
        let cid = clientID()
        print(cid)
        let urlStr = "http://terminal2.expedia.com/x/suggestions/regions?query=\(city)&apikey=\(cid)"
        print(urlStr)
        return NSURL(string: urlStr)!
    }
    
}