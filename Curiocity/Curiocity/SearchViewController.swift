//
//  SecondViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/24/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var citySearches = [City]()
    
    var filteredCitySearches = [City]()

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("SearchViewController")
        print(Utils.getCitySearchResults("San%20Francisco"))
        
        
        citySearches = [
            City(name:"San Francisco"),
            City(name:"San Jose"),
            City(name:"San Diego"),
            City(name:"Santa Clara")
        ]
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterCitySearches(searchText: String, scope: String = "All") {
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
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCitySearches.count
        }
        return citySearches.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CitySearchCell", forIndexPath: indexPath)
        let city: City
        if searchController.active && searchController.searchBar.text != "" {
            city = filteredCitySearches[indexPath.row]
        } else {
            city = citySearches[indexPath.row]
        }
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



}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterCitySearches(searchController.searchBar.text!)
    }
}

