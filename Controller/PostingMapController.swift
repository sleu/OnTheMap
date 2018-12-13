//
//  PostingMapController.swift
//  OnTheMap
//
//  Created by Sean Leu on 12/6/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class PostingMapController: UIViewController, MKMapViewDelegate{
    
    let mapView = MKMapView()
    var selectedLoc = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var locTitle = ""
    var url = ""
    let postingMap = PostingMap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.setMapView()
        self.loadPin()
        
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
        
        let xPostion:CGFloat = 25
        let yPostion:CGFloat = mapHeight - 100
        let buttonHeight:CGFloat = 45
        let finishButton = postingMap.finishButton()
        finishButton.addTarget(self, action: #selector(prepareInformation), for: .touchUpInside)
        finishButton.frame = CGRect(x:xPostion, y:yPostion, width:mapWidth - 50, height:buttonHeight)
        
        let cancelButton = postingMap.cancelButton()
        cancelButton.target = self
        cancelButton.action = #selector(self.cancel)
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.title = postingMap.title
        self.mapView.addSubview(finishButton)
        self.view = self.mapView
    }
    func loadPin() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = selectedLoc
        annotation.title = locTitle
        self.mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: selectedLoc, latitudinalMeters: 4000, longitudinalMeters: 4000)
        self.mapView.setRegion(region, animated: true)
    }
    
    @objc func cancel() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func prepareInformation(){
        UdacClient.sharedInstance.getUser(){ (success, student, errorMessage) in
            if success {
                DispatchQueue.main.async {
                    self.sendInformation(student!)
                }
            } else {
                DispatchQueue.main.async {
                    self.displayNotification(errorMessage!)}
            }
        }
    }
    func sendInformation(_ student: StudentInfo){
        
        let prepStudent = StudentInfo(dictionary: [
            "uniqueKey": student.uniqueKey as AnyObject,
            "firstName": student.firstName as AnyObject,
            "lastName": student.lastName as AnyObject,
            "mapString": locTitle as AnyObject,
            "mediaURL": String(url) as AnyObject,
            "latitude": selectedLoc.latitude as AnyObject,
            "longitude": selectedLoc.longitude as AnyObject])
        if Storage.objectId == "" { //post new student
            ParseClient.sharedInstance.postStudent(prepStudent){ (success, errorMessage) in
                if success {
                    DispatchQueue.main.async {
                        self.complete()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.displayNotification(errorMessage!)}
                    }
                }
        } else { //put update student
            ParseClient.sharedInstance.putStudent(prepStudent){ (success, errorMessage) in
                if success {
                    DispatchQueue.main.async {
                        self.complete()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.displayNotification(errorMessage!)}
                }
            }
        }
    }
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    func complete(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
}
