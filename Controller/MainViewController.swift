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
    let mapTabController = MapsViewController()
    let tableTabController = TableTabViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTabController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_mapview-deselected"), selectedImage: UIImage(named: "icon_mapview-selected"))
        tableTabController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_listview-deselected"), selectedImage: UIImage(named: "icon_listview-selected"))
        
        let viewControllerList = [mapTabController, tableTabController]
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
        loadNavigationBar()
    }
    
    func loadNavigationBar() {
        let addButton = mainView.addButton()
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        let addButtonItem = UIBarButtonItem(customView: addButton)
        
        let refreshButton = mainView.refreshButton()
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        let refreshButtonItem = UIBarButtonItem(customView: refreshButton)
        
        let logOutButton = mainView.logOutButton()
        logOutButton.target = self
        logOutButton.action = #selector(logout)
        self.navigationItem.leftBarButtonItem = logOutButton
        self.navigationItem.rightBarButtonItems = [addButtonItem, refreshButtonItem]
        self.navigationItem.title = mainView.title
    }
    
    @objc func logout() {
        UdacClient.sharedInstance.logout() { (success, errorMessage) in
            if success {
                DispatchQueue.main.async {
                    self.goToLogin()}
            } else {
                self.displayNotification(errorMessage!)
            }
        }
    }
    
    @objc func add() {
        let newVC = PostingViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc func refresh(){
        mapTabController.loadData()
        tableTabController.update()
    }
    
    func goToLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
