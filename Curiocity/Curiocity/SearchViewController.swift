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
    var searchActive : Bool = false
    var citySearches = [City]()
    
    var filteredCitySearches = [City]()

    let searchController = UISearchController(searchResultsController: nil)
    var data = NSData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
        print("SearchViewController")
        
        self.citySearches = []
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
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
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                    print("feedDictionary:", feedDictionary)
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
                            print("APPENDINGGGGG!")
                            self.citySearches.append(City(name: name, lat: lat, long: long))
                            print(self.citySearches)
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
        print("end of loadCities")
    }
    
    func searchBar(searchBar: UISearchBar, var textDidChange searchText: String) {
        self.citySearches = []
        print("searchText \(searchText)")
        if searchText.containsString(" ") {
            searchText = searchText.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        }
        loadCities(searchText, completion: didLoadCities)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("2")
        print("searchText \(searchBar.text)")
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("3")
    }

    
    func filterCitySearches(searchText: String, scope: String = "All") {
        print("filterCitySearches")
        filteredCitySearches = citySearches.filter { city in
            return city.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("IN CELL FOR ROW AT INDEX PATH")
        let cell = tableView.dequeueReusableCellWithIdentifier("CitySearchCell", forIndexPath: indexPath)
        let city: City
        city = citySearches[indexPath.row]
        print("THIS IS MY CITY!")
        print(city)
    
        cell.textLabel?.text = city.name
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showCityDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let city = citySearches[indexPath.row]
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.cityNameLabel = city
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadCities(citySearches: [City]) {
        self.citySearches = citySearches
        self.tableView!.reloadData()
        print("self.citySearches:", self.citySearches)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterCitySearches(searchController.searchBar.text!)
    }
}

