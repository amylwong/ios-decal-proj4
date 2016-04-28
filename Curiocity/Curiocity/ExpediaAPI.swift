//
//  ExpediaAPI.swift
//  Curiocity
//
//  Created by Amy Wong on 4/26/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import Foundation

class ExpediaAPI {

    
    func loadCities(completion: (([City]) -> Void)!) {

        print("ExpediaAPI.swift")
//        let url: NSURL = Utils.getCitySearchResults("San")
        let url = Utils.getCitySearchResults("San")
        print(url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                //FIX ME
                print("%%%%")
                var cities = [City]()
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    // FILL ME IN, REMEMBER TO USE FORCED DOWNCASTING
                    print(feedDictionary)
                    print("____")
                    let arr = feedDictionary.valueForKey("sr") as! NSArray
                    print("arr,",arr)
                    for dict in arr {
                        cities.append(City(data: dict as! NSDictionary))
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
        print("watt")
    }
    
}
