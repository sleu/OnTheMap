//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginView: LoginView {return self.view as! LoginView}
    var emailField: UITextField {return loginView.emailField}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = LoginView()
        emailField.delegate = TextDelegate()
        //passwordField.delegate = TextDelegate()
    }
    

    func loginPressed() {
        //Authenticate
    }
    
}
