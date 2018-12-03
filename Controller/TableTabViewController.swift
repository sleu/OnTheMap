//
//  TableTabViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/16/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class TableTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var arrayData = [StudentInfo]()
    var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayData = Storage.data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let start = CGFloat(0)
        tableView.frame = CGRect(x: start, y: start, width: screenWidth, height: screenHeight)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        let studentUrl = arrayData[indexPath.row].mediaURL
        if let url = URL(string: studentUrl) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            print("fail")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = arrayData[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.imageView?.image = UIImage(named: "icon_pin")
        cell.textLabel?.text = student.firstName + " " + student.lastName
        cell.detailTextLabel?.text = student.mediaURL
        return cell
    }
}
