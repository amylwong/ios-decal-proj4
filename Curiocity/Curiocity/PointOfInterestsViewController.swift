//
//  PointOfInterestsViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/26/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class PointOfInterestsViewController: UITableViewController {
    
    var cityPOI : [PointOfInterest] = []
    var selectedPOI: [String] = []
    var myPOI = [String:PointOfInterest]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("POIViewController")
        let secondTab = self.tabBarController?.viewControllers![1] as! SearchViewController
        let city = secondTab.citySelected
        print(city.name)
        if city != nil {
            loadPOI(city, completion: didLoadPOI)
            print("???")
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView!.reloadData()
//        print("reload")
////        print((self.tabBarController?.viewControllers![1] as! SearchViewController).citySelected.name)
////        self.viewDidLoad()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPOI(city: City, completion: (([PointOfInterest]) -> Void)!) {
        var location = city.name
        if location.containsString(" ") {
            location = location.stringByReplacingOccurrencesOfString(",", withString: "")
            location = location.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        }
        let cid = Utils.clientID()
        let url = NSURL(string: "http://terminal2.expedia.com/x/activities/search?location=\(location)&apikey=\(cid)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if (feedDictionary.valueForKey("activities")) == nil {
                        return
                    }
                    let arr = feedDictionary.valueForKey("activities") as! NSArray
                    for activity in arr {
                        let activityName = activity.valueForKey("title") as! String
                        let latLng = (activity.valueForKey("latLng") as! String).componentsSeparatedByString(",")
                        self.cityPOI.append(PointOfInterest(name: activityName, lat: latLng[0], long: latLng[1]))
                    }
                    // DO NOT CHANGE BELOW
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(self.cityPOI)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        })
        task.resume()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cityPOI.count == 0 {
            let alertController: UIAlertController = UIAlertController(title: "No Points of Interest Found :(", message: "Unfortunately, the API does not have data for this city.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in

            }
            alertController.addAction(okAction)
        }

        return cityPOI.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("POICell", forIndexPath: indexPath)
        let name = cityPOI[indexPath.row].POIName
        cell.textLabel?.text = name
        if selectedPOI.contains(name) {
            cell.accessoryType = .Checkmark
        } else{
            cell.accessoryType = .None
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let name = cityPOI[indexPath.row].POIName 
        print("+",name)
        if !(selectedPOI.contains(name)) {
            selectedPOI.append(name)
            print("+")
            myPOI[name] = cityPOI[indexPath.row]
            print(myPOI)
        } else {
            selectedPOI = selectedPOI.filter() {$0 != name}
            myPOI.removeValueForKey(name)

        }
        tableView.reloadData()
        
    }
    
    
    func didLoadPOI(cityPOI: [PointOfInterest]) {
        self.cityPOI = cityPOI
        self.tableView!.reloadData()
    }
    
}

