//
//  MapViewController.swift
//  Curiocity
//
//  Created by Amy Wong on 4/26/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    var allPOI = [PointOfInterest]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("MapViewController")
        
        
        
        let thirdTab = self.tabBarController?.viewControllers![2] as! PointOfInterestsViewController
        print("myPOI", thirdTab.myPOI)
//        allPOI = thirdTab.myPOI.keys
        let myPOI = thirdTab.myPOI
        addLocations(myPOI)
        let initialLoc = CLLocation(latitude:37.8716, longitude:-122.2727)
        centerMapOnLocation(initialLoc)
        
        print(initialLoc.coordinate)
        let lat = initialLoc.coordinate.latitude
        let long = initialLoc.coordinate.longitude
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = "Initial Location: \(lat), \(long)"
        annotation.subtitle = "I am here"
        mapView.addAnnotation(annotation)
        // show all annotations without zooming out
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    
    func addLocations(poi: [String:PointOfInterest]) {
        for (name, poiObj) in poi {
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(poiObj.lat)!, longitude: Double(poiObj.long)!)
            mapView.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion =
        MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius * 2.0,
            regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

