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
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = name
    }
}