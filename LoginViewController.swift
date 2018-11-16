//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView: LoginView {return self.view as! LoginView}
    var emailField: UITextField {return loginView.emailField}
    var passwordField: UITextField {return loginView.passwordField}
    var loginButton: UIButton {return loginView.loginButton}
    var signupButton: UILabel {return loginView.signupLabel}
    let textDelegate = TextDelegate();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = LoginView()
        emailField.delegate = textDelegate
        passwordField.delegate = textDelegate
        loginButton.addTarget(self, action: #selector(LoginViewController.loginPressed), for: .touchDown)
    }

    @objc func loginPressed() {
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            self.displayNotification("Email or Password is missing")
            return
        }
        UdacClient.sharedInstance.authenticateUser(emailField.text!, passwordField.text!) { (success, errorMessage) in
            if success {
                print("success!")
            } else {
                DispatchQueue.main.async {
                    self.displayNotification("Incorrect Login")
                }
                print(errorMessage!)
            }
            
        }
    }
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
