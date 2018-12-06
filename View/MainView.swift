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
    
    func refreshButton() -> UIButton {
        let refreshButton = UIButton()
        refreshButton.setImage(UIImage(named: "icon_refresh"), for: .normal)
        refreshButton.sizeToFit()
        return refreshButton
    }
    
    func addButton() -> UIButton {
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "icon_addpin"), for: .normal)
        addButton.sizeToFit()
        return addButton
    }
}
