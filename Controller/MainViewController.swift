//
//  MainViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/16/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    let mainView = MainView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapTabController = MapsViewController()
        let tableTabController = TableTabViewController()
        
        mapTabController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_mapview-deselected"), selectedImage: UIImage(named: "icon_mapview-selected"))
        tableTabController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_listview-deselected"), selectedImage: UIImage(named: "icon_listview-selected"))
        
        let viewControllerList = [mapTabController, tableTabController]
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
        loadNavigationBar()
    }
    
    func loadNavigationBar() { //MAY NEED TO REPEAT FOR OTHER BUTTONS IF THEY CALL ON THE CLIENT 
        let logOutButton = mainView.logOutButton()
        logOutButton.target = self
        logOutButton.action = #selector(logout)
        self.navigationItem.leftBarButtonItem = logOutButton
        self.navigationItem.rightBarButtonItems = [mainView.addButton(), mainView.refreshButton()]
        self.navigationItem.title = mainView.title
    }
    
    @objc func logout() {
        print("logout")
        UdacClient.sharedInstance.logout() { (success, errorMessage) in
            if success {
                DispatchQueue.main.async {
                    self.goToLogin()}
            } else {
                print ("unable to logout?!?!")
            }
        }
    }
    
    @objc static func refresh(){
        //MapsViewController.update()
        print("refresh1")
    }
    
    @objc static func add() {
        
        print("add")
    }
    
    func goToLogin() {
        self.dismiss(animated: true, completion: nil)
    }
}
