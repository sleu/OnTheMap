//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/26/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

struct StudentInfo {
    
    var objectId: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
    
    init(dictionary: [String : AnyObject]) {
        self.objectId = dictionary["objectId"] as? String ?? ""
        self.uniqueKey = dictionary["uniqueKey"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.mapString = dictionary["mapString"] as? String ?? ""
        self.mediaURL = dictionary["mediaURL"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? Double ?? 0.0
        self.longitude = dictionary["longitude"] as? Double ?? 0.0
    }
}


