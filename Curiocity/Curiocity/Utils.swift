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
        let urlStr = "http://terminal2.expedia.com:80/x/suggestions/regions?query=\(city)&apikey=\(cid)"
//        let urlStr = "http://terminal2.expedia.com/x/suggestions/regions?query=\(city)&apikey=\(cid)"
        return NSURL(string: urlStr)!
    }
    
    class func getGoogleSearchApiKey() -> String {
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        let apiKey = NSDictionary(contentsOfFile: path!)?.valueForKey("custom_search_engine_api_key") as! String
        return apiKey
    }
    
    class func getSearchEngineKey() -> String {
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        let searchEngineKey = NSDictionary(contentsOfFile: path!)?.valueForKey("search_engine_key") as! String
        return searchEngineKey
    }
}