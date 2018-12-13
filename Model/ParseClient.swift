//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/16/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ParseClient: NSObject {
    
    let appId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    let parseUrl = "https://parse.udacity.com/parse/classes/StudentLocation"
    let session = URLSession.shared
    let limit = 100
    let order = "-UpdatedAt"
    static let sharedInstance = ParseClient()
    private enum Text: String{
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    override init() {
        super.init()
    }
    
    func displayError(_ error: String) {
        print(error)
    }
    
    func getStudents(completionHandlerStudents: @escaping (_ success: Bool, _ students: [StudentInfo]?, _ error: String?) -> Void) {
        let request = prepareUrl(parseUrl, "?limit=\(limit)&order=\(order)", Text.get.rawValue)
        let task = session.dataTask(with: request) {data, response, error in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.displayError("There was an error with your request: \(String(describing: error))")
                completionHandlerStudents(false, nil, error as? String)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                self.displayError("No data was returned by the request!")
                completionHandlerStudents(false, nil, "No data returned")
                return
            }
            
            do{
                let results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                if let parsedResults = results["results"]{
                    var listOfStudents = [StudentInfo]()
                    for student in parsedResults as! [[String: AnyObject]]{
                        listOfStudents.append(StudentInfo(dictionary: student))
                    }
                    completionHandlerStudents(true, listOfStudents, nil)
                }
            }
            catch {
                completionHandlerStudents(false, nil, error as? String)
            }
        }
        task.resume()
    }
    
    func getStudent(_ uniqueKey: Int, completionHandlerStudent: @escaping (_ success: Bool, _ student: StudentInfo?, _ error: String?) -> Void) {
        let request = prepareUrl(parseUrl, "?where={\"uniqueKey\":\"\(uniqueKey)\"}", Text.get.rawValue)
        let task = session.dataTask(with: request) {data, response, error in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.displayError("There was an error with your request: \(String(describing: error))")
                completionHandlerStudent(false, nil, error as? String)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                self.displayError("No data was returned by the request!")
                completionHandlerStudent(false, nil, "No data returned")
                return
            }
            
            do{
                let results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                if let parsedResults = results["results"]{
                    for details in parsedResults as! [[String: AnyObject]]{
                        completionHandlerStudent(true, StudentInfo(dictionary: details), nil)
                    }
                }
            }
            catch {
                completionHandlerStudent(false, nil, error as? String)
            }
        }
        task.resume()
    }
    
    func postStudent(_ student: StudentInfo, completionHandlerPost: @escaping (_ success: Bool, _ error: String?) -> Void) {
        let request = prepareUrl(parseUrl, "{\"uniqueKey\": \"\(student.uniqueKey)\", \"firstName\": \"\(student.firstName)\", \"lastName\": \"\(student.lastName)\",\"mapString\": \"\(student.mapString)\", \"mediaURL\": \"\(student.mediaURL)\",\"latitude\": \(student.latitude), \"longitude\": \(student.longitude)}", Text.post.rawValue)
        let task = session.dataTask(with: request) {data, response, error in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.displayError("There was an error with your request: \(String(describing: error))")
                completionHandlerPost(false, error as? String)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                self.displayError("No data was returned by the request!")
                completionHandlerPost(false, "No data returned")
                return
            }
            let json: [AnyHashable: Any]
            do {
                json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [AnyHashable: Any]
            } catch {
                self.displayError("Could not parse the data as JSON: '\(data)'")
                completionHandlerPost(false, "Corrupt Data")
                return
            }
            let objectId = json["objectId"] as! String
            Storage.objectId = objectId
            completionHandlerPost(true, nil)

        }
        task.resume()
    }
    
    func putStudent(_ student: StudentInfo, completionHandlerPut: @escaping (_ success: Bool, _ error: String?) -> Void){
        let putURL = parseUrl + "/\(Storage.objectId)"
        let request = prepareUrl(putURL, "{\"uniqueKey\": \"\(student.uniqueKey)\", \"firstName\": \"\(student.firstName)\", \"lastName\": \"\(student.lastName)\",\"mapString\": \"\(student.mapString)\", \"mediaURL\": \"\(student.mediaURL)\",\"latitude\": \(student.latitude), \"longitude\": \(student.longitude)}", Text.put.rawValue)
        let task = session.dataTask(with: request) {data, response, error in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.displayError("There was an error with your request: \(String(describing: error))")
                completionHandlerPut(false, error as? String)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                self.displayError("No data was returned by the request!")
                completionHandlerPut(false, "No data returned")
                return
            }
            let json: AnyObject!
            do {
                json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            } catch {
                self.displayError("Could not parse the data as JSON: '\(data)'")
                completionHandlerPut(false, "Corrupt Data")
                return
            }
            if (json["updatedAt"]) != nil {
                completionHandlerPut(true, nil)
            }
        }
        task.resume()
    }
    
    func prepareUrl(_ url: String, _ params: String, _ method: String) -> URLRequest {
        var studentsUrl = url
        var request = URLRequest(url: URL(string: studentsUrl)!)
        if method == Text.get.rawValue{
            studentsUrl = studentsUrl + params
            request = URLRequest(url: URL(string: studentsUrl)!)
        } else {
            request.httpBody = params.data(using: .utf8)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.httpMethod = method
        request.addValue(appId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        return request
    }
}
