//
//  MyTabBarController.swift
//  Curiocity
//
//  Created by Amy Wong on 5/1/16.
//  Copyright © 2016 Amy Wong. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        self.delegate = self
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        print("Selected item")
    }
    
    // UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
//        print("Selected view controller")
    }
}