//
//  CitiesSavedViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/28/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class CitiesSavedViewController : UICollectionViewController {
    
    private let reuseIdentifier = "CityCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var cityPlansSaved = ["Berkeley","Oakland","Concord"]
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        cell.cityNameLabel.text = cityPlansSaved[indexPath.row]
        return cell
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return cityPlansSaved.count
    }
    
}