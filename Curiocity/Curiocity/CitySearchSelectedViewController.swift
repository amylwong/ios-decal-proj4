//
//  CitySearchSelectedViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/28/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class CitySearchSelectedViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var citySnippet: UILabel!
    
    @IBOutlet weak var button: UIButton!
    var name = String()
    var snippet = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: "toPointOfInterestTab", forControlEvents: .TouchUpInside)
        cityNameLabel.text = name
//        dispatch_async(dispatch_get_main_queue(), {
//            self.loadInformation("Oakland+Ca", completion: self.didLoadInformation)
//        })
        citySnippet.text = snippet
        print("view did load", citySnippet.text)
        print("snippet",self.snippet)
        citySnippet.text = snippet

    }
    
    func toPointOfInterestTab() {
        print("Button tapped")
//        var tabBarController: UITabBarController = self.window?.rootViewController as? UITabBarController

//        tabBarController?.selectedIndex = 1
    }
    

//    
//    func loadInformation(searchQuery: String, completion: ((String) -> Void)!) {
//        let url = NSURL(string: "https://www.googleapis.com/customsearch/v1?q=oahu+island+hi&key=AIzaSyC23XfzfqEsuqZYEH2QBQHp7ZV8A89mCj0&cx=002821250313775171056:qylbfxx5bm8")
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
//            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//            print(error)
//            if error == nil {
//                do {
//                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                    
//                    self.citySnippet.text = (feedDictionary.valueForKey("items")![0].valueForKey("snippet"))! as? String
//                    // DO NOT CHANGE BELOW
//                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                        dispatch_async(dispatch_get_main_queue()) {
//                            completion(self.snippet)
//                        }
//                    }
//                } catch let error as NSError {
//                    print("ERROR: \(error.localizedDescription)")
//                }
//            }
//        })
//        task.resume()
//    }
//    
//    
//    func didLoadInformation(info: String) {
//        self.snippet = info
//    }

}