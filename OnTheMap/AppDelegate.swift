//
//  AppDelegate.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/12/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Initialize the window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        if let window = window {
            let mainVC = MainViewController()
            window.rootViewController = mainVC
            window.backgroundColor = UIColor.white
            window.makeKeyAndVisible()
        }
        return true
    }
    
}

