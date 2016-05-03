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
    var allPOI = [String:PointOfInterest]()
    var initial : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("MapViewController")
        //        mapView.removeAnnotations(mapView.annotations)
        //        var annotations = [MKPointAnnotation]()
        //        let thirdTab = self.tabBarController?.viewControllers![2] as! PointOfInterestsViewController
        //        thirdTab.tableView!.reloadData()
        //        print("myPOI", thirdTab.myPOI)
        //        allPOI = thirdTab.myPOI
        //        for (name, poiObj) in allPOI {
        //            let annotation = MKPointAnnotation()
        //            annotation.title = name
        //            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(poiObj.lat)!, longitude: Double(poiObj.long)!)
        //            mapView.addAnnotation(annotation)
        //            annotations.append(annotation)
        //            print("annotation added for: \(name)")
        //        }
        //
        //        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //        self.viewDidLoad()
        print("reload MAPVIEW")
        print("curent annotations", mapView.annotations)
        allPOI.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        print("after remove annotations", mapView.annotations)
        var annotations = [MKPointAnnotation]()
        let thirdTab = self.tabBarController?.viewControllers![2] as! PointOfInterestsViewController
        thirdTab.tableView!.reloadData()
        print("myPOI", thirdTab.myPOI)
        allPOI = thirdTab.myPOI
        for (name, poiObj) in allPOI {
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(poiObj.lat)!, longitude: Double(poiObj.long)!)
            mapView.addAnnotation(annotation)
            annotations.append(annotation)
            print("annotation added for: \(name)")
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        
    }
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView!) {
        // this is where visible maprect should be set
        print("hii")
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion =
        MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius * 15.0,
            regionRadius * 15.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

