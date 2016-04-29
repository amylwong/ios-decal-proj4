//
//  ExpediaAPI.swift
//  Curiocity
//
//  Created by Amy Wong on 4/26/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import Foundation

class ExpediaAPI {

    var data = NSData()
    
    func loadCities(searchQuery: String, completion: (([City]) -> Void)!) {
        print("ExpediaAPI.swift")
        let url = Utils.getCitySearchResults(searchQuery)
        print(url)
        print("searchQuery:", searchQuery)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print(error)
            if error == nil {
                //FIX ME
                print("???")
                var cities = [City]()
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    // FILL ME IN, REMEMBER TO USE FORCED DOWNCASTING
                    print("feedDictionary:", feedDictionary)
                    if feedDictionary.valueForKey("rc") as! String == "ZERO_RESULTS" {
                        return
                    }
                    let arr = feedDictionary.valueForKey("sr") as! NSArray
                    print("arr,",arr)
                    for dict in arr {
                        if dict.valueForKey("t") as! String == "CITY" {
                            print(dict.valueForKey("d"))
                            let name = dict.valueForKey("d") as! String
                            let lat = 34
                            let long = 122
                            cities.append(City(name: name, lat: lat, long: long))
                        }
                    }
                    
                    // DO NOT CHANGE BELOW
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(cities)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
                
            }
        })
        task.resume()
        print("end of loadCities")
    }
    
}
