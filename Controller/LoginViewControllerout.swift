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
    var signupView: UIView {return loginView.signupView}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = LoginView()
        emailField.delegate = self
        passwordField.delegate = self
        loginButton.addTarget(self, action: #selector(LoginViewController.loginPressed), for: .touchDown)
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    @objc func loginPressed() {
        let email = emailField.text!.trimmingCharacters(in: .whitespaces)
        let password = passwordField.text!.trimmingCharacters(in: .whitespaces)
        guard !email.isEmpty && !password.isEmpty else {
            self.displayNotification("Email or Password is missing")
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        UdacClient.sharedInstance.authenticateUser(emailField.text!, passwordField.text!) { (success, errorMessage) in
            if success {
                DispatchQueue.main.async {
                    self.clearText()
                    self.switchToMain()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else {
                DispatchQueue.main.async {
                    self.displayNotification(errorMessage ?? "Incorrect Username or Password")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func switchToMain() {
        let newVC = MainViewController()
        var navController: UINavigationController?
        navController = UINavigationController(rootViewController: newVC)
        self.present(navController!, animated: true, completion: nil)
    }
    func clearText() {
        emailField.text = ""
        passwordField.text = ""
    }
}
extension LoginViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -signupView.frame.origin.y+80
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
        
    }
    
    func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

private extension LoginViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
