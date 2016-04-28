//
//  CitiesViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/24/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    var cities = ["Berkeley", "Oakland"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("CitiesViewController")
//        cities = [
//            City(data:"San Francisco"),
//        ]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("citySavedCell", forIndexPath: indexPath) as! CitySavedTableViewCell
        cell.savedCityNameLabel.text = cities[indexPath.row]
        return cell
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath)
//        
//        let city = cities[indexPath.row]
//        cell.textLabel!.text = city.name
//        return cell
//    }
}

