//
//  UdacClient.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/14/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

class UdacClient: NSObject {
    
    var session = URLSession.shared
    var sessionID: String? = nil
    var userID: Int? = nil
    let udacUrl = "https://www.udacity.com/api/session"
    static let sharedInstance = UdacClient()
    
    override init() {
        super.init()
    }
    
    func displayError(_ error: String) {
        print(error)
    }
    
    func authenticateUser(_ email:String, _ password:String, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void){
        var request = URLRequest(url: URL(string: udacUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.displayError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                self.displayError("No data was returned by the request!")
                return
            }
            
            let usableData = self.subsetData(data)
            let parsedResult: AnyObject!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: usableData, options: .allowFragments) as AnyObject
            } catch {
                self.displayError("Could not parse the data as JSON: '\(usableData)'")
                return
            }
            print(parsedResult)
            
        }
        task.resume()
    }
    
    func subsetData(_ dataset: Data) -> Data {
        let range = (5..<dataset.count)
        let newData = dataset.subdata(in: range)
        return newData
    }
}
