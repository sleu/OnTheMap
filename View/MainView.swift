//
//  MainView.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/20/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    let title = "On the Map"
    
    func logOutButton() -> UIBarButtonItem {
        let logout = UIBarButtonItem(title: "LOGOUT", style: .plain, target: nil, action: nil)
        return logout
    }
    
    func refreshButton() -> UIBarButtonItem {
        let refreshButton = UIButton()
        refreshButton.setImage(UIImage(named: "icon_refresh"), for: .normal)
        refreshButton.addTarget(MainViewController.self, action: #selector(MainViewController.refresh), for: .touchUpInside)
        refreshButton.sizeToFit()
        let refresh = UIBarButtonItem(customView: refreshButton)
        
        return refresh
    }
    
    func addButton() -> UIBarButtonItem {
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "icon_addpin"), for: .normal)
        addButton.addTarget(MainViewController.self, action: #selector(MainViewController.add), for: .touchUpInside)
        addButton.sizeToFit()
        let add = UIBarButtonItem(customView: addButton)
        return add
    }
}
