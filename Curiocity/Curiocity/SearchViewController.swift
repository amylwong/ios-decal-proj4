 //
//  SecondViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/24/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    let api = ExpediaAPI()
    var citySearches = [City]()
    var citySelected : City!
    var cityToSave : City!

    let searchController = UISearchController(searchResultsController: nil)
    var data = NSData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("SearchViewController")
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
        
        self.citySearches = []
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.reloadData()
        print("SearchViewController---viewWillAppear")
        searchController.searchBar.hidden = false
//        // clear previous search findings
//        citySearches.removeAll()
        tableView!.reloadData()
//
    }
    
    func loadCities(searchQuery: String, completion: (([City]) -> Void)!) {
        let url = Utils.getCitySearchResults(searchQuery)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if feedDictionary.valueForKey("rc") as! String == "ZERO_RESULTS" {
                        return
                    }
                    let arr = feedDictionary.valueForKey("sr") as! NSArray
                    for dict in arr {
                        if dict.valueForKey("t") as! String == "CITY" {
                            self.citySearches.append(City(dict: dict as! NSDictionary))
                            self.tableView.reloadData()
                        }
                    }
                    // DO NOT CHANGE BELOW
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(self.citySearches)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        })
        task.resume()
    }
    

    
    func searchBar(searchBar: UISearchBar, var textDidChange searchText: String) {
        self.citySearches = []
        if searchText.containsString(" ") {
            searchText = searchText.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        }
        if searchText != "" {
            loadCities(searchText, completion: didLoadCities)
            self.tableView!.reloadData()
        } 
        if searchText == "" {
            self.citySearches = []
            self.tableView!.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        print("2")
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        print("3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citySearches.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertController: UIAlertController = UIAlertController(title: "City Saved!", message: "Proceed to explore point of interests.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
//            NSLog("OK Pressed")
            self.searchController.searchBar.text = ""
            
        }
        self.searchController.active = false
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
        self.citySelected = citySearches[indexPath.row]
        citySearches.removeAll()
        let POITab = self.tabBarController?.viewControllers![2] as! PointOfInterestsViewController
        POITab.cityPOI.removeAll()
        POITab.myPOI.removeAll()
        print("going to POIViewController from search")
        tabBarController?.selectedIndex = 2
        let savedCitiesTab = self.tabBarController?.viewControllers![0] as! CitiesSavedViewController
        
        for city in savedCitiesTab.cityPlansSaved {
            if city.name == self.citySelected.name {
                return
            }
        }
        savedCitiesTab.cityPlansSaved.append(citySelected)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CitySearchCell", forIndexPath: indexPath)
        let city: City
        city = citySearches[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        let destVC = segue.destinationViewController as! CitySearchSelectedViewController
        if (segue.identifier == "toCitySelected") {
            if let indexPath = tableView.indexPathForSelectedRow {
                let city = citySearches[indexPath.row]
                destVC.cityObj = city
                destVC.name = city.name
            }
            return
        }
    }
    
    
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadCities(citySearches: [City]) {
        self.citySearches = citySearches
        self.tableView!.reloadData()
    }
}

