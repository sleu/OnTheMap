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
    
    override init() {
        super.init()
    }
    
    func displayError(_ error: String) {
        print(error)
    }
    
    func getStudents(completionHandlerStudents: @escaping (_ success: Bool, _ students: [StudentInfo]?, _ error: String?) -> Void) {
        
        let request = prepareUrl("?limit=\(limit)&order=\(order)")
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
        let request = prepareUrl("?where={\"uniqueKey\":\"\(uniqueKey)\"}")
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
    
    func prepareUrl(_ params: String) -> URLRequest {
        let studentsUrl = parseUrl + params
        var request = URLRequest(url: URL(string: studentsUrl)!)
        request.httpMethod = "GET"
        request.addValue(appId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        return request
    }
}
