//
//  CitiesSavedViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/28/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class CitiesSavedViewController : UICollectionViewController {

    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
//    var cityPlansSaved = ["Berkeley"]
    var cityPlansSaved = [City]()
    
    override func viewDidLoad() {
        print("CitiesSavedViewController.swift")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let reuseIdentifier = (indexPath.item == 0) ? "AddCityCell" : "CityCell"
        if reuseIdentifier == "AddCityCell" {
            tabBarController?.selectedIndex = 1
        }
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let height = 100
            return CGSizeMake(collectionView.bounds.size.width - 10, CGFloat(height))
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,atIndexPath indexPath: NSIndexPath) ->UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            headerView.backgroundColor = UIColor.themeColor()
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = (indexPath.item == 0) ? "AddCityCell" : "CityCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CityCell
        cell.layer.borderColor = UIColor.themeColor().CGColor
        cell.layer.borderWidth = 1
        if reuseIdentifier == "CityCell" {
            cell.cityNameLabel.text = cityPlansSaved[indexPath.item-1].name
        }
        return cell
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityPlansSaved.count + 1
    }
    
}