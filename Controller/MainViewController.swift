//
//  MainViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/16/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapTabController = MapsViewController()
        let tableTabController = TableTabViewController()
        
        mapTabController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        tableTabController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllerList = [mapTabController, tableTabController]
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
