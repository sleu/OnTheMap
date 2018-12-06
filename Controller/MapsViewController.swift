//
//  MapsViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/16/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import MapKit
/**
 TODO:
 - load 100 latest pins
 - tap a pin displays pin annotation popup
 - tapping anywhere in annotation loads safari
 - tapping outside of annotation dismiss/hide
 
 **/
class MapsViewController: UIViewController, MKMapViewDelegate{
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.setMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setMapView() {
        let leftMargin: CGFloat = 0
        let topMargin: CGFloat = 0
        let mapWidth: CGFloat = view.frame.size.width
        let mapHeight: CGFloat = view.frame.size.height
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        view.addSubview(mapView)
        
        self.loadData()
    }
    
    func loadData() {
        ParseClient.sharedInstance.getStudents(){ (success, students, error) in
            if success {
                DispatchQueue.main.async {
                    if let students = students {
                        Storage.data = students
                        self.update()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.displayNotification(error!)}
            }
        }
    }
    
    func update() {
        mapView.removeAnnotations(mapView.annotations)
        var annotations = [MKPointAnnotation]()
        for dictionary in Storage.data {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: dictionary.latitude, longitude: dictionary.longitude)
            annotation.title = dictionary.firstName + " " + dictionary.lastName
            annotation.subtitle = dictionary.mediaURL
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
    }
    
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    //TODO: OPEN PIN TO WEBSITE
}
